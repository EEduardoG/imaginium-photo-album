// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidecar_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SidecarPhoto _$SidecarPhotoFromJson(Map<String, dynamic> json) => SidecarPhoto(
      version: (json['version'] as num).toInt(),
      photoHash: json['photoHash'] as String,
      category: json['category'] as String?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => SidecarTag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      description: json['description'] as String?,
      aiProcessed: json['aiProcessed'] as bool? ?? false,
      ollamaProcessed: json['ollamaProcessed'] as bool? ?? false,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$SidecarPhotoToJson(SidecarPhoto instance) =>
    <String, dynamic>{
      'version': instance.version,
      'photoHash': instance.photoHash,
      'category': instance.category,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'aiProcessed': instance.aiProcessed,
      'ollamaProcessed': instance.ollamaProcessed,
      'updatedAt': instance.updatedAt,
    };

SidecarTag _$SidecarTagFromJson(Map<String, dynamic> json) => SidecarTag(
      name: json['name'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      source: json['source'] as String,
    );

Map<String, dynamic> _$SidecarTagToJson(SidecarTag instance) =>
    <String, dynamic>{
      'name': instance.name,
      'confidence': instance.confidence,
      'source': instance.source,
    };
