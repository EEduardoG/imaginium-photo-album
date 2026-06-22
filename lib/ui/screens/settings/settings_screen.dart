import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import '../../../providers.dart';
import '../../../services/directory_watcher_service.dart';

/// Application settings screen with sections for Security, AI, Proton Drive,
/// Gallery, Storage, and About.
///
/// The "Watched Directories" section lets users manage which directories are
/// monitored for automatic photo import.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watcher = ref.watch(directoryWatcherServiceProvider);
    final watchedDirs = watcher.watchedDirectories;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _sectionHeader(context, 'Security'),
          SwitchListTile(
            title: const Text('Biometric Lock'),
            subtitle: const Text('Require Face ID / fingerprint to open app'),
            value: false,
            onChanged: (_) {},
          ),
          SwitchListTile(
            title: const Text('SQLCipher Encryption'),
            subtitle: const Text('Encrypt the local database'),
            value: false,
            onChanged: (_) {},
          ),
          SwitchListTile(
            title: const Text('Private Vault'),
            subtitle: const Text('Hidden album with separate PIN'),
            value: false,
            onChanged: (_) {},
          ),
          SwitchListTile(
            title: const Text('Decoy Mode'),
            subtitle: const Text('Fake vault with decoy PIN'),
            value: false,
            onChanged: (_) {},
          ),
          SwitchListTile(
            title: const Text('GPS Stripping'),
            subtitle: const Text('Remove GPS coordinates before uploading'),
            value: true,
            onChanged: (_) {},
          ),
          const Divider(),
          _sectionHeader(context, 'AI'),
          const ListTile(
            title: Text('TFLite Models'),
            subtitle: Text('YOLO-NAS + MobileNetV3 · Active'),
            leading: Icon(Icons.check_circle, color: Colors.green),
          ),
          SwitchListTile(
            title: const Text('Ollama (Desktop)'),
            subtitle: const Text('Advanced AI tags and descriptions'),
            value: false,
            onChanged: (_) {},
          ),
          const Divider(),
          _sectionHeader(context, 'Proton Drive'),
          const ListTile(
            title: Text('Status'),
            subtitle: Text('Not installed'),
            leading: Icon(Icons.cloud_off, color: Colors.orange),
            trailing: Icon(Icons.info_outline),
          ),
          const Divider(),
          _sectionHeader(context, 'Gallery'),
          ListTile(
            title: const Text('Group by'),
            subtitle: const Text('Year'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(),

          // ---------------------------------------------------------------
          // Watched Directories
          // ---------------------------------------------------------------
          _sectionHeader(context, 'Watched Directories'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'Photos added to these directories are automatically imported '
              'and categorized by AI.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
            ),
          ),
          if (watchedDirs.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'No directories being watched',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          else
            ...watchedDirs.map((dir) => _WatchedDirectoryTile(
                  path: dir,
                  isDefault: _isDefaultDirectory(dir),
                  onRemove: () => watcher.removeDirectory(dir),
                )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton.icon(
              onPressed: () => _addDirectory(context, watcher),
              icon: const Icon(Icons.add),
              label: const Text('Add directory'),
            ),
          ),

          const Divider(),
          _sectionHeader(context, 'Storage'),
          ListTile(
            title: const Text('Cache size'),
            subtitle: const Text('0 MB'),
          ),
          const Divider(),
          _sectionHeader(context, 'About'),
          const ListTile(
            title: Text('Version'),
            subtitle: Text('0.1.0'),
          ),
          ListTile(
            title: const Text('Report error'),
            leading: const Icon(Icons.bug_report),
            onTap: () {
              // TODO: Open error report flow.
            },
          ),
        ],
      ),
    );
  }

  /// Opens a file picker so the user can select a directory to watch.
  Future<void> _addDirectory(
    BuildContext context,
    DirectoryWatcherService watcher,
  ) async {
    final path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select a directory to watch for new photos',
    );
    if (path == null || !context.mounted) return;

    await watcher.addDirectory(path);

    // Refresh settings UI.
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('Now watching: $path'),
        ),
      );
    }
  }

  /// Whether [path] is one of the default watched directories.
  bool _isDefaultDirectory(String path) {
    final home = _homeDirectory();
    if (home == null) return false;
    return path == p.join(home, 'Downloads') ||
        path == p.join(home, 'Pictures');
  }

  String? _homeDirectory() {
    return Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'];
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

/// Tile for a single watched directory with a remove button.
class _WatchedDirectoryTile extends StatelessWidget {
  const _WatchedDirectoryTile({
    required this.path,
    required this.isDefault,
    required this.onRemove,
  });

  final String path;
  final bool isDefault;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isDefault ? Icons.folder_special : Icons.folder,
        color: isDefault ? Colors.blue : null,
      ),
      title: Text(
        path,
        style: const TextStyle(fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: isDefault
          ? const Text('Default', style: TextStyle(fontSize: 11))
          : null,
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
        onPressed: () => _confirmRemove(context),
        tooltip: 'Stop watching',
      ),
    );
  }

  void _confirmRemove(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Stop watching?'),
        content: Text(
          'New photos added to this directory will no longer be '
          'imported automatically.\n\n$path',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onRemove();
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

