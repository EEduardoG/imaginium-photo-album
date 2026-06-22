import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether the current platform is a desktop OS (Windows, macOS, or Linux).
final isDesktopProvider = Provider<bool>((ref) {
  if (kIsWeb) return false;
  return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
});

/// Whether the current platform is a mobile OS (iOS or Android).
final isMobileProvider = Provider<bool>((ref) {
  if (kIsWeb) return false;
  return Platform.isAndroid || Platform.isIOS;
});

/// The current platform as a human-readable string.
final platformNameProvider = Provider<String>((ref) {
  if (kIsWeb) return 'web';
  if (Platform.isWindows) return 'windows';
  if (Platform.isMacOS) return 'macos';
  if (Platform.isLinux) return 'linux';
  if (Platform.isAndroid) return 'android';
  if (Platform.isIOS) return 'ios';
  return 'unknown';
});

/// Application domain enum for compile-time checks when needed.
enum AppPlatform { desktop, mobile, unknown }

AppPlatform get currentAppPlatform {
  if (kIsWeb) return AppPlatform.unknown;
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    return AppPlatform.desktop;
  }
  if (Platform.isAndroid || Platform.isIOS) {
    return AppPlatform.mobile;
  }
  return AppPlatform.unknown;
}
