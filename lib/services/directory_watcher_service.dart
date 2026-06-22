import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';
import '../core/constants.dart';

/// Result emitted when a new media file is detected in a watched directory.
class WatchedFileEvent {
  const WatchedFileEvent({
    required this.path,
    required this.eventType,
  });

  final String path;
  final WatchEventType eventType;
}

enum WatchEventType { created, modified }

/// Service that monitors configured directories for new or modified media
/// files using the [watcher] package.
///
/// Default watched directories: `~/Downloads` and `~/Pictures`.
/// Supported formats are defined in [AppConstants].
/// Emits file paths via [fileStream] when a new supported file is detected.
class DirectoryWatcherService {
  DirectoryWatcherService()
      : _subscriptions = {},
        _watchedDirectories = [],
        _isRunning = false;

  /// Map of directory path → active stream subscription.
  final Map<String, StreamSubscription<WatchEvent>> _subscriptions;
  final List<String> _watchedDirectories;
  bool _isRunning;

  /// Controller for broadcasting new file events.
  final StreamController<WatchedFileEvent> _fileController =
      StreamController<WatchedFileEvent>.broadcast();

  /// Stream of newly detected media file paths.
  Stream<WatchedFileEvent> get fileStream => _fileController.stream;

  /// Whether the watcher is currently monitoring directories.
  bool get isRunning => _isRunning;

  /// The list of currently watched directory paths.
  List<String> get watchedDirectories => List.unmodifiable(_watchedDirectories);

  // -----------------------------------------------------------------------
  // Lifecycle
  // -----------------------------------------------------------------------

  /// Start watching the default directories plus any previously added
  /// custom directories.
  Future<void> start({List<String>? directories}) async {
    if (_isRunning) return;

    final dirs = directories ?? _buildDefaultDirectories();
    debugPrint('[DirectoryWatcher] Starting watcher for ${dirs.length} directories');
    debugPrint('[DirectoryWatcher] Dirs: $dirs');

    for (final dir in dirs) {
      // Track the directory path so the UI can display it.
      if (!_watchedDirectories.contains(dir)) {
        _watchedDirectories.add(dir);
      }
      await _addWatcher(dir);
    }

    _isRunning = true;
    debugPrint('[DirectoryWatcher] Watcher started. Active subscriptions: ${_subscriptions.length}');
  }

  /// Stop all directory watchers by canceling their stream subscriptions.
  Future<void> stop() async {
    for (final sub in _subscriptions.values) {
      await sub.cancel();
    }
    _subscriptions.clear();
    _isRunning = false;
  }

  /// Add a directory to the watch list. Takes effect immediately if the
  /// service is running, or queues for next [start()].
  Future<void> addDirectory(String path) async {
    final normalized = Directory(path).absolute.path;
    if (_watchedDirectories.contains(normalized)) return;
    _watchedDirectories.add(normalized);

    if (_isRunning) {
      await _addWatcher(normalized);
    }
  }

  /// Remove a directory from the watch list.
  Future<void> removeDirectory(String path) async {
    final normalized = Directory(path).absolute.path;
    _watchedDirectories.remove(normalized);

    final sub = _subscriptions.remove(normalized);
    if (sub != null) {
      await sub.cancel();
    }
  }

  /// Dispose the stream controller. Call when the app is shutting down.
  void dispose() {
    stop();
    if (!_fileController.isClosed) {
      _fileController.close();
    }
  }

  // -----------------------------------------------------------------------
  // Private helpers
  // -----------------------------------------------------------------------

  /// Builds the default list of directories to watch based on the user's
  /// home directory.
  List<String> _buildDefaultDirectories() {
    final home = _homeDirectory();
    if (home == null) return [];

    final defaults = <String>[
      p.join(home, 'Downloads'),
      p.join(home, 'Pictures'),
    ];

    // Merge with any explicitly added directories, keeping defaults first.
    for (final dir in _watchedDirectories) {
      if (!defaults.contains(dir)) {
        defaults.add(dir);
      }
    }

    return defaults;
  }

  /// Adds a watcher for [directoryPath] if it exists.
  Future<void> _addWatcher(String directoryPath) async {
    final dir = Directory(directoryPath);
    final absPath = dir.absolute.path;

    // Skip if already watching this path.
    if (_subscriptions.containsKey(absPath)) {
      debugPrint('[DirectoryWatcher] Already watching: $absPath');
      return;
    }

    // Skip if directory does not exist (e.g., ~/Pictures missing on some
    // distros). The user can add directories manually via Settings.
    if (!await dir.exists()) {
      debugPrint('[DirectoryWatcher] Directory does not exist, skipping: $absPath');
      return;
    }

    debugPrint('[DirectoryWatcher] Adding watcher for: $absPath');
    final watcher = DirectoryWatcher(absPath);
    final sub = watcher.events.listen((event) {
      final eventTypeStr =
          event is FileSystemCreateEvent
              ? 'Create'
              : event is FileSystemModifyEvent
                  ? 'Modify'
                  : event is FileSystemDeleteEvent
                      ? 'Delete'
                      : event is FileSystemMoveEvent
                          ? 'Move'
                          : 'WatchEvent';
      debugPrint('[DirectoryWatcher] Raw event: $eventTypeStr path=${event.path}'
          ' type=${event.type}');

      // Accept any event except deletions.
      if (event.type == ChangeType.REMOVE) return;

      final filePath = event.path;
      final isSupported = _isSupportedFormat(filePath);
      debugPrint('[DirectoryWatcher] File: $filePath supported=$isSupported ext=${p.extension(filePath)}');

      if (isSupported) {
        // Skip Chrome/Chromium temp download files (*.crdownload).
        if (filePath.endsWith('.crdownload')) {
          debugPrint('[DirectoryWatcher] Skipping temp download file: $filePath');
          return;
        }

        // Small delay to let the file system finish writing.
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!_fileController.isClosed) {
            debugPrint('[DirectoryWatcher] Emitting WatchedFileEvent for: $filePath');
            _fileController.add(WatchedFileEvent(
              path: filePath,
              eventType: event is FileSystemCreateEvent ||
                      event.type == ChangeType.ADD
                  ? WatchEventType.created
                  : WatchEventType.modified,
            ));
          }
        });
      }
    });

    _subscriptions[absPath] = sub;
  }

  /// Checks if [filePath] has a supported image or video extension.
  bool _isSupportedFormat(String filePath) {
    final ext = p.extension(filePath).toLowerCase().replaceAll('.', '');
    return AppConstants.supportedImageFormats.contains(ext) ||
        AppConstants.supportedVideoFormats.contains(ext);
  }

  /// Returns the user's home directory path, or null if unavailable.
  String? _homeDirectory() {
    final home = Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'];
    return home;
  }
}
