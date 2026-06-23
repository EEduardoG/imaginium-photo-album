import 'package:json_annotation/json_annotation.dart';

part 'sidecar_photo.g.dart';

/// Model for the `.photo.json` sidecar file stored next to each media file.
///
/// This portable metadata enables cross-device sync via Proton Drive and
/// serves as a distributed backup that can rebuild the local database.
@JsonSerializable(explicitToJson: true)
class SidecarPhoto {
  const SidecarPhoto({
    required this.version,
    required this.photoHash,
    this.category,
    this.tags = const [],
    this.description,
    this.aiProcessed = false,
    this.ollamaProcessed = false,
    required this.updatedAt,
  });

  factory SidecarPhoto.fromJson(Map<String, dynamic> json) =>
      _$SidecarPhotoFromJson(json);

  /// Sidecar format version for forward compatibility.
  final int version;

  /// SHA-256 hash of the media file (links sidecar to its media).
  final String photoHash;

  /// Primary category (people, nature, urban, food, etc.).
  final String? category;

  /// List of tags assigned by AI or user.
  final List<SidecarTag> tags;

  /// Human-readable description (from Ollama or user).
  final String? description;

  /// Whether the core TFLite AI has processed this file.
  final bool aiProcessed;

  /// Whether Ollama has enriched this file with advanced tags.
  final bool ollamaProcessed;

  /// ISO 8601 timestamp of the last modification.
  final String updatedAt;

  Map<String, dynamic> toJson() => _$SidecarPhotoToJson(this);

  SidecarPhoto copyWith({
    int? version,
    String? photoHash,
    String? category,
    List<SidecarTag>? tags,
    String? description,
    bool? aiProcessed,
    bool? ollamaProcessed,
    String? updatedAt,
  }) {
    return SidecarPhoto(
      version: version ?? this.version,
      photoHash: photoHash ?? this.photoHash,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      aiProcessed: aiProcessed ?? this.aiProcessed,
      ollamaProcessed: ollamaProcessed ?? this.ollamaProcessed,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// A single tag entry within the sidecar JSON.
@JsonSerializable()
class SidecarTag {
  const SidecarTag({
    required this.name,
    required this.confidence,
    required this.source,
  });

  factory SidecarTag.fromJson(Map<String, dynamic> json) =>
      _$SidecarTagFromJson(json);

  /// Tag name (e.g., "dog", "beach", "sunset").
  final String name;

  /// AI confidence score (0.0 to 1.0).
  final double confidence;

  /// Source of this tag: ai_detector, ai_classifier, ai_ollama, or manual.
  final String source;

  Map<String, dynamic> toJson() => _$SidecarTagToJson(this);
}
