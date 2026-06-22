import 'package:flutter/material.dart';

/// Application settings screen with sections for Security, AI, Proton Drive,
/// Gallery, Storage, and About.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          ListTile(
            title: const Text('TFLite Models'),
            subtitle: const Text('YOLO-NAS + MobileNetV3 · Active'),
            leading: const Icon(Icons.check_circle, color: Colors.green),
          ),
          SwitchListTile(
            title: const Text('Ollama (Desktop)'),
            subtitle: const Text('Advanced AI tags and descriptions'),
            value: false,
            onChanged: (_) {},
          ),
          const Divider(),
          _sectionHeader(context, 'Proton Drive'),
          ListTile(
            title: const Text('Status'),
            subtitle: const Text('Not installed'),
            leading: const Icon(Icons.cloud_off, color: Colors.orange),
            trailing: const Icon(Icons.info_outline),
          ),
          const Divider(),
          _sectionHeader(context, 'Gallery'),
          ListTile(
            title: const Text('Group by'),
            subtitle: const Text('Year'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(),
          _sectionHeader(context, 'Storage'),
          ListTile(
            title: const Text('Scanned folders'),
            subtitle: const Text('0 folders'),
            trailing: const Icon(Icons.chevron_right),
          ),
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
