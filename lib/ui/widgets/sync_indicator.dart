import 'package:flutter/material.dart';
import '../../data/database/tables.dart';

/// Icon indicator showing the Proton Drive sync status of a photo.
///
/// States: synced, pending upload, pending download, conflict, local only.
class SyncIndicator extends StatelessWidget {
  const SyncIndicator({
    super.key,
    this.status,
    this.size = 16,
  });

  /// The sync status. If null, nothing is shown (photo not tracked for sync).
  final SyncStatus? status;

  /// Icon size in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    if (status == null) return const SizedBox.shrink();

    return Semantics(
      label: switch (status!) {
        SyncStatus.synced => 'Synced with Proton Drive',
        SyncStatus.pendingUpload => 'Pending upload to Proton',
        SyncStatus.pendingDownload => 'Available for download from Proton',
        SyncStatus.conflict => 'Sync conflict',
        SyncStatus.localOnly => 'Local only, not synced',
      },
      child: Icon(
        _icon,
        size: size,
        color: _color,
      ),
    );
  }

  IconData get _icon => switch (status!) {
        SyncStatus.synced => Icons.cloud_done,
        SyncStatus.pendingUpload => Icons.cloud_upload,
        SyncStatus.pendingDownload => Icons.cloud_download,
        SyncStatus.conflict => Icons.cloud_off,
        SyncStatus.localOnly => Icons.cloud_outlined,
      };

  Color get _color => switch (status!) {
        SyncStatus.synced => Colors.green,
        SyncStatus.pendingUpload => Colors.orange,
        SyncStatus.pendingDownload => Colors.blue,
        SyncStatus.conflict => Colors.red,
        SyncStatus.localOnly => Colors.grey,
      };
}
