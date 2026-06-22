import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'core/platform_check.dart';
import 'ui/screens/gallery/gallery_screen.dart';

/// Root widget for the Imaginium Photo Album application.
class ImaginiumApp extends ConsumerWidget {
  const ImaginiumApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ref.watch(isDesktopProvider);

    return MaterialApp(
      title: 'Imaginium Photo Album',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const GalleryScreen(),
    );
  }
}
