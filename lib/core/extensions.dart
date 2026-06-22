/// Convenience extensions used across the application.
extension StringExtensions on String {
  /// Returns a user-friendly file size representation.
  String get asFileSize {
    final bytes = int.tryParse(this);
    if (bytes == null) return this;
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

extension IntExtensions on int {
  /// Formats the integer as a file size string.
  String get asFileSize => toString().asFileSize;

  /// Formats milliseconds as a human-readable duration (mm:ss or hh:mm:ss).
  String get asDuration {
    final totalSeconds = this ~/ 1000;
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
    }
    return '${minutes}m ${seconds.toString().padLeft(2, '0')}s';
  }
}

extension DateTimeExtensions on DateTime {
  /// Whether this date falls in the same calendar year as [other].
  bool isSameYear(DateTime other) => year == other.year;

  /// Whether this date falls in the same calendar month as [other].
  bool isSameMonth(DateTime other) =>
      year == other.year && month == other.month;
}
