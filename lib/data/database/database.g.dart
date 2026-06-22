// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PhotosTable extends Photos with TableInfo<$PhotosTable, Photo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filenameMeta =
      const VerificationMeta('filename');
  @override
  late final GeneratedColumn<String> filename = GeneratedColumn<String>(
      'filename', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mediaTypeMeta =
      const VerificationMeta('mediaType');
  @override
  late final GeneratedColumnWithTypeConverter<MediaType, String> mediaType =
      GeneratedColumn<String>('media_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MediaType>($PhotosTable.$convertermediaType);
  static const VerificationMeta _sha256HashMeta =
      const VerificationMeta('sha256Hash');
  @override
  late final GeneratedColumn<String> sha256Hash = GeneratedColumn<String>(
      'sha256_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _perceptualHashMeta =
      const VerificationMeta('perceptualHash');
  @override
  late final GeneratedColumn<String> perceptualHash = GeneratedColumn<String>(
      'perceptual_hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
      'size_bytes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
      'width', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
      'format', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMsMeta =
      const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
      'duration_ms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _codecMeta = const VerificationMeta('codec');
  @override
  late final GeneratedColumn<String> codec = GeneratedColumn<String>(
      'codec', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fpsMeta = const VerificationMeta('fps');
  @override
  late final GeneratedColumn<double> fps = GeneratedColumn<double>(
      'fps', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _takenAtMeta =
      const VerificationMeta('takenAt');
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
      'taken_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        path,
        filename,
        mediaType,
        sha256Hash,
        perceptualHash,
        sizeBytes,
        width,
        height,
        format,
        durationMs,
        codec,
        fps,
        takenAt,
        deletedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(Insertable<Photo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename']!, _filenameMeta));
    } else if (isInserting) {
      context.missing(_filenameMeta);
    }
    context.handle(_mediaTypeMeta, const VerificationResult.success());
    if (data.containsKey('sha256_hash')) {
      context.handle(
          _sha256HashMeta,
          sha256Hash.isAcceptableOrUnknown(
              data['sha256_hash']!, _sha256HashMeta));
    } else if (isInserting) {
      context.missing(_sha256HashMeta);
    }
    if (data.containsKey('perceptual_hash')) {
      context.handle(
          _perceptualHashMeta,
          perceptualHash.isAcceptableOrUnknown(
              data['perceptual_hash']!, _perceptualHashMeta));
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    }
    if (data.containsKey('codec')) {
      context.handle(
          _codecMeta, codec.isAcceptableOrUnknown(data['codec']!, _codecMeta));
    }
    if (data.containsKey('fps')) {
      context.handle(
          _fpsMeta, fps.isAcceptableOrUnknown(data['fps']!, _fpsMeta));
    }
    if (data.containsKey('taken_at')) {
      context.handle(_takenAtMeta,
          takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Photo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Photo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      filename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filename'])!,
      mediaType: $PhotosTable.$convertermediaType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_type'])!),
      sha256Hash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sha256_hash'])!,
      perceptualHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}perceptual_hash']),
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bytes'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}width']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height']),
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      durationMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_ms']),
      codec: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codec']),
      fps: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fps']),
      takenAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}taken_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MediaType, String, String> $convertermediaType =
      const EnumNameConverter<MediaType>(MediaType.values);
}

class Photo extends DataClass implements Insertable<Photo> {
  final String id;
  final String path;
  final String filename;
  final MediaType mediaType;
  final String sha256Hash;
  final String? perceptualHash;
  final int sizeBytes;
  final int? width;
  final int? height;

  /// File extension without dot (jpg, png, mp4, mov...).
  final String format;

  /// Duration in milliseconds (videos only).
  final int? durationMs;

  /// Video codec (h264, h265, vp9), null for photos.
  final String? codec;

  /// Frames per second (videos only).
  final double? fps;

  /// EXIF / recording date.
  final DateTime? takenAt;

  /// Soft-delete timestamp. NULL = active.
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Photo(
      {required this.id,
      required this.path,
      required this.filename,
      required this.mediaType,
      required this.sha256Hash,
      this.perceptualHash,
      required this.sizeBytes,
      this.width,
      this.height,
      required this.format,
      this.durationMs,
      this.codec,
      this.fps,
      this.takenAt,
      this.deletedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['path'] = Variable<String>(path);
    map['filename'] = Variable<String>(filename);
    {
      map['media_type'] =
          Variable<String>($PhotosTable.$convertermediaType.toSql(mediaType));
    }
    map['sha256_hash'] = Variable<String>(sha256Hash);
    if (!nullToAbsent || perceptualHash != null) {
      map['perceptual_hash'] = Variable<String>(perceptualHash);
    }
    map['size_bytes'] = Variable<int>(sizeBytes);
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    map['format'] = Variable<String>(format);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    if (!nullToAbsent || codec != null) {
      map['codec'] = Variable<String>(codec);
    }
    if (!nullToAbsent || fps != null) {
      map['fps'] = Variable<double>(fps);
    }
    if (!nullToAbsent || takenAt != null) {
      map['taken_at'] = Variable<DateTime>(takenAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      path: Value(path),
      filename: Value(filename),
      mediaType: Value(mediaType),
      sha256Hash: Value(sha256Hash),
      perceptualHash: perceptualHash == null && nullToAbsent
          ? const Value.absent()
          : Value(perceptualHash),
      sizeBytes: Value(sizeBytes),
      width:
          width == null && nullToAbsent ? const Value.absent() : Value(width),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      format: Value(format),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      codec:
          codec == null && nullToAbsent ? const Value.absent() : Value(codec),
      fps: fps == null && nullToAbsent ? const Value.absent() : Value(fps),
      takenAt: takenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(takenAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Photo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Photo(
      id: serializer.fromJson<String>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      filename: serializer.fromJson<String>(json['filename']),
      mediaType: $PhotosTable.$convertermediaType
          .fromJson(serializer.fromJson<String>(json['mediaType'])),
      sha256Hash: serializer.fromJson<String>(json['sha256Hash']),
      perceptualHash: serializer.fromJson<String?>(json['perceptualHash']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      format: serializer.fromJson<String>(json['format']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      codec: serializer.fromJson<String?>(json['codec']),
      fps: serializer.fromJson<double?>(json['fps']),
      takenAt: serializer.fromJson<DateTime?>(json['takenAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'path': serializer.toJson<String>(path),
      'filename': serializer.toJson<String>(filename),
      'mediaType': serializer
          .toJson<String>($PhotosTable.$convertermediaType.toJson(mediaType)),
      'sha256Hash': serializer.toJson<String>(sha256Hash),
      'perceptualHash': serializer.toJson<String?>(perceptualHash),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'format': serializer.toJson<String>(format),
      'durationMs': serializer.toJson<int?>(durationMs),
      'codec': serializer.toJson<String?>(codec),
      'fps': serializer.toJson<double?>(fps),
      'takenAt': serializer.toJson<DateTime?>(takenAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Photo copyWith(
          {String? id,
          String? path,
          String? filename,
          MediaType? mediaType,
          String? sha256Hash,
          Value<String?> perceptualHash = const Value.absent(),
          int? sizeBytes,
          Value<int?> width = const Value.absent(),
          Value<int?> height = const Value.absent(),
          String? format,
          Value<int?> durationMs = const Value.absent(),
          Value<String?> codec = const Value.absent(),
          Value<double?> fps = const Value.absent(),
          Value<DateTime?> takenAt = const Value.absent(),
          Value<DateTime?> deletedAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Photo(
        id: id ?? this.id,
        path: path ?? this.path,
        filename: filename ?? this.filename,
        mediaType: mediaType ?? this.mediaType,
        sha256Hash: sha256Hash ?? this.sha256Hash,
        perceptualHash:
            perceptualHash.present ? perceptualHash.value : this.perceptualHash,
        sizeBytes: sizeBytes ?? this.sizeBytes,
        width: width.present ? width.value : this.width,
        height: height.present ? height.value : this.height,
        format: format ?? this.format,
        durationMs: durationMs.present ? durationMs.value : this.durationMs,
        codec: codec.present ? codec.value : this.codec,
        fps: fps.present ? fps.value : this.fps,
        takenAt: takenAt.present ? takenAt.value : this.takenAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Photo copyWithCompanion(PhotosCompanion data) {
    return Photo(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
      filename: data.filename.present ? data.filename.value : this.filename,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      sha256Hash:
          data.sha256Hash.present ? data.sha256Hash.value : this.sha256Hash,
      perceptualHash: data.perceptualHash.present
          ? data.perceptualHash.value
          : this.perceptualHash,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      format: data.format.present ? data.format.value : this.format,
      durationMs:
          data.durationMs.present ? data.durationMs.value : this.durationMs,
      codec: data.codec.present ? data.codec.value : this.codec,
      fps: data.fps.present ? data.fps.value : this.fps,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Photo(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('filename: $filename, ')
          ..write('mediaType: $mediaType, ')
          ..write('sha256Hash: $sha256Hash, ')
          ..write('perceptualHash: $perceptualHash, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('format: $format, ')
          ..write('durationMs: $durationMs, ')
          ..write('codec: $codec, ')
          ..write('fps: $fps, ')
          ..write('takenAt: $takenAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      path,
      filename,
      mediaType,
      sha256Hash,
      perceptualHash,
      sizeBytes,
      width,
      height,
      format,
      durationMs,
      codec,
      fps,
      takenAt,
      deletedAt,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Photo &&
          other.id == this.id &&
          other.path == this.path &&
          other.filename == this.filename &&
          other.mediaType == this.mediaType &&
          other.sha256Hash == this.sha256Hash &&
          other.perceptualHash == this.perceptualHash &&
          other.sizeBytes == this.sizeBytes &&
          other.width == this.width &&
          other.height == this.height &&
          other.format == this.format &&
          other.durationMs == this.durationMs &&
          other.codec == this.codec &&
          other.fps == this.fps &&
          other.takenAt == this.takenAt &&
          other.deletedAt == this.deletedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PhotosCompanion extends UpdateCompanion<Photo> {
  final Value<String> id;
  final Value<String> path;
  final Value<String> filename;
  final Value<MediaType> mediaType;
  final Value<String> sha256Hash;
  final Value<String?> perceptualHash;
  final Value<int> sizeBytes;
  final Value<int?> width;
  final Value<int?> height;
  final Value<String> format;
  final Value<int?> durationMs;
  final Value<String?> codec;
  final Value<double?> fps;
  final Value<DateTime?> takenAt;
  final Value<DateTime?> deletedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.filename = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.sha256Hash = const Value.absent(),
    this.perceptualHash = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.format = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.codec = const Value.absent(),
    this.fps = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotosCompanion.insert({
    required String id,
    required String path,
    required String filename,
    required MediaType mediaType,
    required String sha256Hash,
    this.perceptualHash = const Value.absent(),
    required int sizeBytes,
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    required String format,
    this.durationMs = const Value.absent(),
    this.codec = const Value.absent(),
    this.fps = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        path = Value(path),
        filename = Value(filename),
        mediaType = Value(mediaType),
        sha256Hash = Value(sha256Hash),
        sizeBytes = Value(sizeBytes),
        format = Value(format);
  static Insertable<Photo> custom({
    Expression<String>? id,
    Expression<String>? path,
    Expression<String>? filename,
    Expression<String>? mediaType,
    Expression<String>? sha256Hash,
    Expression<String>? perceptualHash,
    Expression<int>? sizeBytes,
    Expression<int>? width,
    Expression<int>? height,
    Expression<String>? format,
    Expression<int>? durationMs,
    Expression<String>? codec,
    Expression<double>? fps,
    Expression<DateTime>? takenAt,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (filename != null) 'filename': filename,
      if (mediaType != null) 'media_type': mediaType,
      if (sha256Hash != null) 'sha256_hash': sha256Hash,
      if (perceptualHash != null) 'perceptual_hash': perceptualHash,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (format != null) 'format': format,
      if (durationMs != null) 'duration_ms': durationMs,
      if (codec != null) 'codec': codec,
      if (fps != null) 'fps': fps,
      if (takenAt != null) 'taken_at': takenAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotosCompanion copyWith(
      {Value<String>? id,
      Value<String>? path,
      Value<String>? filename,
      Value<MediaType>? mediaType,
      Value<String>? sha256Hash,
      Value<String?>? perceptualHash,
      Value<int>? sizeBytes,
      Value<int?>? width,
      Value<int?>? height,
      Value<String>? format,
      Value<int?>? durationMs,
      Value<String?>? codec,
      Value<double?>? fps,
      Value<DateTime?>? takenAt,
      Value<DateTime?>? deletedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PhotosCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      filename: filename ?? this.filename,
      mediaType: mediaType ?? this.mediaType,
      sha256Hash: sha256Hash ?? this.sha256Hash,
      perceptualHash: perceptualHash ?? this.perceptualHash,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      width: width ?? this.width,
      height: height ?? this.height,
      format: format ?? this.format,
      durationMs: durationMs ?? this.durationMs,
      codec: codec ?? this.codec,
      fps: fps ?? this.fps,
      takenAt: takenAt ?? this.takenAt,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(
          $PhotosTable.$convertermediaType.toSql(mediaType.value));
    }
    if (sha256Hash.present) {
      map['sha256_hash'] = Variable<String>(sha256Hash.value);
    }
    if (perceptualHash.present) {
      map['perceptual_hash'] = Variable<String>(perceptualHash.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (codec.present) {
      map['codec'] = Variable<String>(codec.value);
    }
    if (fps.present) {
      map['fps'] = Variable<double>(fps.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('filename: $filename, ')
          ..write('mediaType: $mediaType, ')
          ..write('sha256Hash: $sha256Hash, ')
          ..write('perceptualHash: $perceptualHash, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('format: $format, ')
          ..write('durationMs: $durationMs, ')
          ..write('codec: $codec, ')
          ..write('fps: $fps, ')
          ..write('takenAt: $takenAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumnWithTypeConverter<TagSource, String> source =
      GeneratedColumn<String>('source', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TagSource>($TagsTable.$convertersource);
  @override
  List<GeneratedColumn> get $columns => [id, name, color, source];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    context.handle(_sourceMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      source: $TagsTable.$convertersource.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TagSource, String, String> $convertersource =
      const EnumNameConverter<TagSource>(TagSource.values);
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String name;
  final String? color;
  final TagSource source;
  const Tag(
      {required this.id, required this.name, this.color, required this.source});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    {
      map['source'] =
          Variable<String>($TagsTable.$convertersource.toSql(source));
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      source: Value(source),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      source: $TagsTable.$convertersource
          .fromJson(serializer.fromJson<String>(json['source'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'source':
          serializer.toJson<String>($TagsTable.$convertersource.toJson(source)),
    };
  }

  Tag copyWith(
          {String? id,
          String? name,
          Value<String?> color = const Value.absent(),
          TagSource? source}) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color.present ? color.value : this.color,
        source: source ?? this.source,
      );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, source);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.source == this.source);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> color;
  final Value<TagSource> source;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String name,
    this.color = const Value.absent(),
    required TagSource source,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        source = Value(source);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? color,
      Value<TagSource>? source,
      Value<int>? rowid}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (source.present) {
      map['source'] =
          Variable<String>($TagsTable.$convertersource.toSql(source.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotoTagsTable extends PhotoTags
    with TableInfo<$PhotoTagsTable, PhotoTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _photoIdMeta =
      const VerificationMeta('photoId');
  @override
  late final GeneratedColumn<String> photoId = GeneratedColumn<String>(
      'photo_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES photos (id) ON DELETE CASCADE'));
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tags (id) ON DELETE CASCADE'));
  static const VerificationMeta _confidenceMeta =
      const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
      'confidence', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumnWithTypeConverter<TagSource, String> source =
      GeneratedColumn<String>('source', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TagSource>($PhotoTagsTable.$convertersource);
  @override
  List<GeneratedColumn> get $columns => [photoId, tagId, confidence, source];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_tags';
  @override
  VerificationContext validateIntegrity(Insertable<PhotoTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('photo_id')) {
      context.handle(_photoIdMeta,
          photoId.isAcceptableOrUnknown(data['photo_id']!, _photoIdMeta));
    } else if (isInserting) {
      context.missing(_photoIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
          _confidenceMeta,
          confidence.isAcceptableOrUnknown(
              data['confidence']!, _confidenceMeta));
    }
    context.handle(_sourceMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {photoId, tagId};
  @override
  PhotoTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoTag(
      photoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_id'])!,
      confidence: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}confidence']),
      source: $PhotoTagsTable.$convertersource.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!),
    );
  }

  @override
  $PhotoTagsTable createAlias(String alias) {
    return $PhotoTagsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TagSource, String, String> $convertersource =
      const EnumNameConverter<TagSource>(TagSource.values);
}

class PhotoTag extends DataClass implements Insertable<PhotoTag> {
  final String photoId;
  final String tagId;
  final double? confidence;
  final TagSource source;
  const PhotoTag(
      {required this.photoId,
      required this.tagId,
      this.confidence,
      required this.source});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['photo_id'] = Variable<String>(photoId);
    map['tag_id'] = Variable<String>(tagId);
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    {
      map['source'] =
          Variable<String>($PhotoTagsTable.$convertersource.toSql(source));
    }
    return map;
  }

  PhotoTagsCompanion toCompanion(bool nullToAbsent) {
    return PhotoTagsCompanion(
      photoId: Value(photoId),
      tagId: Value(tagId),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
      source: Value(source),
    );
  }

  factory PhotoTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoTag(
      photoId: serializer.fromJson<String>(json['photoId']),
      tagId: serializer.fromJson<String>(json['tagId']),
      confidence: serializer.fromJson<double?>(json['confidence']),
      source: $PhotoTagsTable.$convertersource
          .fromJson(serializer.fromJson<String>(json['source'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'photoId': serializer.toJson<String>(photoId),
      'tagId': serializer.toJson<String>(tagId),
      'confidence': serializer.toJson<double?>(confidence),
      'source': serializer
          .toJson<String>($PhotoTagsTable.$convertersource.toJson(source)),
    };
  }

  PhotoTag copyWith(
          {String? photoId,
          String? tagId,
          Value<double?> confidence = const Value.absent(),
          TagSource? source}) =>
      PhotoTag(
        photoId: photoId ?? this.photoId,
        tagId: tagId ?? this.tagId,
        confidence: confidence.present ? confidence.value : this.confidence,
        source: source ?? this.source,
      );
  PhotoTag copyWithCompanion(PhotoTagsCompanion data) {
    return PhotoTag(
      photoId: data.photoId.present ? data.photoId.value : this.photoId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      confidence:
          data.confidence.present ? data.confidence.value : this.confidence,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoTag(')
          ..write('photoId: $photoId, ')
          ..write('tagId: $tagId, ')
          ..write('confidence: $confidence, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(photoId, tagId, confidence, source);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoTag &&
          other.photoId == this.photoId &&
          other.tagId == this.tagId &&
          other.confidence == this.confidence &&
          other.source == this.source);
}

class PhotoTagsCompanion extends UpdateCompanion<PhotoTag> {
  final Value<String> photoId;
  final Value<String> tagId;
  final Value<double?> confidence;
  final Value<TagSource> source;
  final Value<int> rowid;
  const PhotoTagsCompanion({
    this.photoId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.confidence = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoTagsCompanion.insert({
    required String photoId,
    required String tagId,
    this.confidence = const Value.absent(),
    required TagSource source,
    this.rowid = const Value.absent(),
  })  : photoId = Value(photoId),
        tagId = Value(tagId),
        source = Value(source);
  static Insertable<PhotoTag> custom({
    Expression<String>? photoId,
    Expression<String>? tagId,
    Expression<double>? confidence,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (photoId != null) 'photo_id': photoId,
      if (tagId != null) 'tag_id': tagId,
      if (confidence != null) 'confidence': confidence,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoTagsCompanion copyWith(
      {Value<String>? photoId,
      Value<String>? tagId,
      Value<double?>? confidence,
      Value<TagSource>? source,
      Value<int>? rowid}) {
    return PhotoTagsCompanion(
      photoId: photoId ?? this.photoId,
      tagId: tagId ?? this.tagId,
      confidence: confidence ?? this.confidence,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (photoId.present) {
      map['photo_id'] = Variable<String>(photoId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
          $PhotoTagsTable.$convertersource.toSql(source.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoTagsCompanion(')
          ..write('photoId: $photoId, ')
          ..write('tagId: $tagId, ')
          ..write('confidence: $confidence, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  const Category({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Category copyWith({String? id, String? name}) => Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category && other.id == this.id && other.name == this.name);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotoCategoriesTable extends PhotoCategories
    with TableInfo<$PhotoCategoriesTable, PhotoCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _photoIdMeta =
      const VerificationMeta('photoId');
  @override
  late final GeneratedColumn<String> photoId = GeneratedColumn<String>(
      'photo_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES photos (id) ON DELETE CASCADE'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories (id) ON DELETE CASCADE'));
  static const VerificationMeta _confidenceMeta =
      const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
      'confidence', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [photoId, categoryId, confidence];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_categories';
  @override
  VerificationContext validateIntegrity(Insertable<PhotoCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('photo_id')) {
      context.handle(_photoIdMeta,
          photoId.isAcceptableOrUnknown(data['photo_id']!, _photoIdMeta));
    } else if (isInserting) {
      context.missing(_photoIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
          _confidenceMeta,
          confidence.isAcceptableOrUnknown(
              data['confidence']!, _confidenceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {photoId, categoryId};
  @override
  PhotoCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoCategory(
      photoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      confidence: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}confidence']),
    );
  }

  @override
  $PhotoCategoriesTable createAlias(String alias) {
    return $PhotoCategoriesTable(attachedDatabase, alias);
  }
}

class PhotoCategory extends DataClass implements Insertable<PhotoCategory> {
  final String photoId;
  final String categoryId;
  final double? confidence;
  const PhotoCategory(
      {required this.photoId, required this.categoryId, this.confidence});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['photo_id'] = Variable<String>(photoId);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    return map;
  }

  PhotoCategoriesCompanion toCompanion(bool nullToAbsent) {
    return PhotoCategoriesCompanion(
      photoId: Value(photoId),
      categoryId: Value(categoryId),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
    );
  }

  factory PhotoCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoCategory(
      photoId: serializer.fromJson<String>(json['photoId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      confidence: serializer.fromJson<double?>(json['confidence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'photoId': serializer.toJson<String>(photoId),
      'categoryId': serializer.toJson<String>(categoryId),
      'confidence': serializer.toJson<double?>(confidence),
    };
  }

  PhotoCategory copyWith(
          {String? photoId,
          String? categoryId,
          Value<double?> confidence = const Value.absent()}) =>
      PhotoCategory(
        photoId: photoId ?? this.photoId,
        categoryId: categoryId ?? this.categoryId,
        confidence: confidence.present ? confidence.value : this.confidence,
      );
  PhotoCategory copyWithCompanion(PhotoCategoriesCompanion data) {
    return PhotoCategory(
      photoId: data.photoId.present ? data.photoId.value : this.photoId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      confidence:
          data.confidence.present ? data.confidence.value : this.confidence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoCategory(')
          ..write('photoId: $photoId, ')
          ..write('categoryId: $categoryId, ')
          ..write('confidence: $confidence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(photoId, categoryId, confidence);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoCategory &&
          other.photoId == this.photoId &&
          other.categoryId == this.categoryId &&
          other.confidence == this.confidence);
}

class PhotoCategoriesCompanion extends UpdateCompanion<PhotoCategory> {
  final Value<String> photoId;
  final Value<String> categoryId;
  final Value<double?> confidence;
  final Value<int> rowid;
  const PhotoCategoriesCompanion({
    this.photoId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.confidence = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoCategoriesCompanion.insert({
    required String photoId,
    required String categoryId,
    this.confidence = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : photoId = Value(photoId),
        categoryId = Value(categoryId);
  static Insertable<PhotoCategory> custom({
    Expression<String>? photoId,
    Expression<String>? categoryId,
    Expression<double>? confidence,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (photoId != null) 'photo_id': photoId,
      if (categoryId != null) 'category_id': categoryId,
      if (confidence != null) 'confidence': confidence,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoCategoriesCompanion copyWith(
      {Value<String>? photoId,
      Value<String>? categoryId,
      Value<double?>? confidence,
      Value<int>? rowid}) {
    return PhotoCategoriesCompanion(
      photoId: photoId ?? this.photoId,
      categoryId: categoryId ?? this.categoryId,
      confidence: confidence ?? this.confidence,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (photoId.present) {
      map['photo_id'] = Variable<String>(photoId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoCategoriesCompanion(')
          ..write('photoId: $photoId, ')
          ..write('categoryId: $categoryId, ')
          ..write('confidence: $confidence, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, Album> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isHiddenMeta =
      const VerificationMeta('isHidden');
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
      'is_hidden', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_hidden" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _coverPhotoIdMeta =
      const VerificationMeta('coverPhotoId');
  @override
  late final GeneratedColumn<String> coverPhotoId = GeneratedColumn<String>(
      'cover_photo_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, isHidden, coverPhotoId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'albums';
  @override
  VerificationContext validateIntegrity(Insertable<Album> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_hidden')) {
      context.handle(_isHiddenMeta,
          isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta));
    }
    if (data.containsKey('cover_photo_id')) {
      context.handle(
          _coverPhotoIdMeta,
          coverPhotoId.isAcceptableOrUnknown(
              data['cover_photo_id']!, _coverPhotoIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Album map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Album(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isHidden: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_hidden'])!,
      coverPhotoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_photo_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(attachedDatabase, alias);
  }
}

class Album extends DataClass implements Insertable<Album> {
  final String id;
  final String name;
  final String? description;

  /// Whether this album is hidden (requires auth to view).
  final bool isHidden;
  final String? coverPhotoId;
  final DateTime createdAt;
  const Album(
      {required this.id,
      required this.name,
      this.description,
      required this.isHidden,
      this.coverPhotoId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_hidden'] = Variable<bool>(isHidden);
    if (!nullToAbsent || coverPhotoId != null) {
      map['cover_photo_id'] = Variable<String>(coverPhotoId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isHidden: Value(isHidden),
      coverPhotoId: coverPhotoId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPhotoId),
      createdAt: Value(createdAt),
    );
  }

  factory Album.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Album(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
      coverPhotoId: serializer.fromJson<String?>(json['coverPhotoId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isHidden': serializer.toJson<bool>(isHidden),
      'coverPhotoId': serializer.toJson<String?>(coverPhotoId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Album copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          bool? isHidden,
          Value<String?> coverPhotoId = const Value.absent(),
          DateTime? createdAt}) =>
      Album(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        isHidden: isHidden ?? this.isHidden,
        coverPhotoId:
            coverPhotoId.present ? coverPhotoId.value : this.coverPhotoId,
        createdAt: createdAt ?? this.createdAt,
      );
  Album copyWithCompanion(AlbumsCompanion data) {
    return Album(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
      coverPhotoId: data.coverPhotoId.present
          ? data.coverPhotoId.value
          : this.coverPhotoId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Album(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isHidden: $isHidden, ')
          ..write('coverPhotoId: $coverPhotoId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, isHidden, coverPhotoId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Album &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isHidden == this.isHidden &&
          other.coverPhotoId == this.coverPhotoId &&
          other.createdAt == this.createdAt);
}

class AlbumsCompanion extends UpdateCompanion<Album> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isHidden;
  final Value<String?> coverPhotoId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AlbumsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.coverPhotoId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.coverPhotoId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Album> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isHidden,
    Expression<String>? coverPhotoId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isHidden != null) 'is_hidden': isHidden,
      if (coverPhotoId != null) 'cover_photo_id': coverPhotoId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<bool>? isHidden,
      Value<String?>? coverPhotoId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AlbumsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isHidden: isHidden ?? this.isHidden,
      coverPhotoId: coverPhotoId ?? this.coverPhotoId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (coverPhotoId.present) {
      map['cover_photo_id'] = Variable<String>(coverPhotoId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isHidden: $isHidden, ')
          ..write('coverPhotoId: $coverPhotoId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlbumPhotosTable extends AlbumPhotos
    with TableInfo<$AlbumPhotosTable, AlbumPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _albumIdMeta =
      const VerificationMeta('albumId');
  @override
  late final GeneratedColumn<String> albumId = GeneratedColumn<String>(
      'album_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES albums (id) ON DELETE CASCADE'));
  static const VerificationMeta _photoIdMeta =
      const VerificationMeta('photoId');
  @override
  late final GeneratedColumn<String> photoId = GeneratedColumn<String>(
      'photo_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES photos (id) ON DELETE CASCADE'));
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [albumId, photoId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'album_photos';
  @override
  VerificationContext validateIntegrity(Insertable<AlbumPhoto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta));
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('photo_id')) {
      context.handle(_photoIdMeta,
          photoId.isAcceptableOrUnknown(data['photo_id']!, _photoIdMeta));
    } else if (isInserting) {
      context.missing(_photoIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {albumId, photoId};
  @override
  AlbumPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlbumPhoto(
      albumId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album_id'])!,
      photoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
    );
  }

  @override
  $AlbumPhotosTable createAlias(String alias) {
    return $AlbumPhotosTable(attachedDatabase, alias);
  }
}

class AlbumPhoto extends DataClass implements Insertable<AlbumPhoto> {
  final String albumId;
  final String photoId;
  final int position;
  const AlbumPhoto(
      {required this.albumId, required this.photoId, required this.position});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['album_id'] = Variable<String>(albumId);
    map['photo_id'] = Variable<String>(photoId);
    map['position'] = Variable<int>(position);
    return map;
  }

  AlbumPhotosCompanion toCompanion(bool nullToAbsent) {
    return AlbumPhotosCompanion(
      albumId: Value(albumId),
      photoId: Value(photoId),
      position: Value(position),
    );
  }

  factory AlbumPhoto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlbumPhoto(
      albumId: serializer.fromJson<String>(json['albumId']),
      photoId: serializer.fromJson<String>(json['photoId']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'albumId': serializer.toJson<String>(albumId),
      'photoId': serializer.toJson<String>(photoId),
      'position': serializer.toJson<int>(position),
    };
  }

  AlbumPhoto copyWith({String? albumId, String? photoId, int? position}) =>
      AlbumPhoto(
        albumId: albumId ?? this.albumId,
        photoId: photoId ?? this.photoId,
        position: position ?? this.position,
      );
  AlbumPhoto copyWithCompanion(AlbumPhotosCompanion data) {
    return AlbumPhoto(
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      photoId: data.photoId.present ? data.photoId.value : this.photoId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlbumPhoto(')
          ..write('albumId: $albumId, ')
          ..write('photoId: $photoId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(albumId, photoId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlbumPhoto &&
          other.albumId == this.albumId &&
          other.photoId == this.photoId &&
          other.position == this.position);
}

class AlbumPhotosCompanion extends UpdateCompanion<AlbumPhoto> {
  final Value<String> albumId;
  final Value<String> photoId;
  final Value<int> position;
  final Value<int> rowid;
  const AlbumPhotosCompanion({
    this.albumId = const Value.absent(),
    this.photoId = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumPhotosCompanion.insert({
    required String albumId,
    required String photoId,
    required int position,
    this.rowid = const Value.absent(),
  })  : albumId = Value(albumId),
        photoId = Value(photoId),
        position = Value(position);
  static Insertable<AlbumPhoto> custom({
    Expression<String>? albumId,
    Expression<String>? photoId,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (albumId != null) 'album_id': albumId,
      if (photoId != null) 'photo_id': photoId,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumPhotosCompanion copyWith(
      {Value<String>? albumId,
      Value<String>? photoId,
      Value<int>? position,
      Value<int>? rowid}) {
    return AlbumPhotosCompanion(
      albumId: albumId ?? this.albumId,
      photoId: photoId ?? this.photoId,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    if (photoId.present) {
      map['photo_id'] = Variable<String>(photoId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumPhotosCompanion(')
          ..write('albumId: $albumId, ')
          ..write('photoId: $photoId, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStatusTableTable extends SyncStatusTable
    with TableInfo<$SyncStatusTableTable, SyncStatusTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStatusTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _photoIdMeta =
      const VerificationMeta('photoId');
  @override
  late final GeneratedColumn<String> photoId = GeneratedColumn<String>(
      'photo_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES photos (id) ON DELETE CASCADE'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<SyncStatus>($SyncStatusTableTable.$converterstatus);
  static const VerificationMeta _protonFileIdMeta =
      const VerificationMeta('protonFileId');
  @override
  late final GeneratedColumn<String> protonFileId = GeneratedColumn<String>(
      'proton_file_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sidecarSyncedMeta =
      const VerificationMeta('sidecarSynced');
  @override
  late final GeneratedColumn<bool> sidecarSynced = GeneratedColumn<bool>(
      'sidecar_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sidecar_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [photoId, status, protonFileId, sidecarSynced, lastSyncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_status_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SyncStatusTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('photo_id')) {
      context.handle(_photoIdMeta,
          photoId.isAcceptableOrUnknown(data['photo_id']!, _photoIdMeta));
    } else if (isInserting) {
      context.missing(_photoIdMeta);
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('proton_file_id')) {
      context.handle(
          _protonFileIdMeta,
          protonFileId.isAcceptableOrUnknown(
              data['proton_file_id']!, _protonFileIdMeta));
    }
    if (data.containsKey('sidecar_synced')) {
      context.handle(
          _sidecarSyncedMeta,
          sidecarSynced.isAcceptableOrUnknown(
              data['sidecar_synced']!, _sidecarSyncedMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {photoId};
  @override
  SyncStatusTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStatusTableData(
      photoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_id'])!,
      status: $SyncStatusTableTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      protonFileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}proton_file_id']),
      sidecarSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sidecar_synced'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
    );
  }

  @override
  $SyncStatusTableTable createAlias(String alias) {
    return $SyncStatusTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, String, String> $converterstatus =
      const EnumNameConverter<SyncStatus>(SyncStatus.values);
}

class SyncStatusTableData extends DataClass
    implements Insertable<SyncStatusTableData> {
  final String photoId;
  final SyncStatus status;
  final String? protonFileId;

  /// Whether the sidecar .photo.json has been synced to Proton.
  final bool sidecarSynced;
  final DateTime? lastSyncedAt;
  const SyncStatusTableData(
      {required this.photoId,
      required this.status,
      this.protonFileId,
      required this.sidecarSynced,
      this.lastSyncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['photo_id'] = Variable<String>(photoId);
    {
      map['status'] = Variable<String>(
          $SyncStatusTableTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || protonFileId != null) {
      map['proton_file_id'] = Variable<String>(protonFileId);
    }
    map['sidecar_synced'] = Variable<bool>(sidecarSynced);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  SyncStatusTableCompanion toCompanion(bool nullToAbsent) {
    return SyncStatusTableCompanion(
      photoId: Value(photoId),
      status: Value(status),
      protonFileId: protonFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(protonFileId),
      sidecarSynced: Value(sidecarSynced),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory SyncStatusTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStatusTableData(
      photoId: serializer.fromJson<String>(json['photoId']),
      status: $SyncStatusTableTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      protonFileId: serializer.fromJson<String?>(json['protonFileId']),
      sidecarSynced: serializer.fromJson<bool>(json['sidecarSynced']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'photoId': serializer.toJson<String>(photoId),
      'status': serializer.toJson<String>(
          $SyncStatusTableTable.$converterstatus.toJson(status)),
      'protonFileId': serializer.toJson<String?>(protonFileId),
      'sidecarSynced': serializer.toJson<bool>(sidecarSynced),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  SyncStatusTableData copyWith(
          {String? photoId,
          SyncStatus? status,
          Value<String?> protonFileId = const Value.absent(),
          bool? sidecarSynced,
          Value<DateTime?> lastSyncedAt = const Value.absent()}) =>
      SyncStatusTableData(
        photoId: photoId ?? this.photoId,
        status: status ?? this.status,
        protonFileId:
            protonFileId.present ? protonFileId.value : this.protonFileId,
        sidecarSynced: sidecarSynced ?? this.sidecarSynced,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
      );
  SyncStatusTableData copyWithCompanion(SyncStatusTableCompanion data) {
    return SyncStatusTableData(
      photoId: data.photoId.present ? data.photoId.value : this.photoId,
      status: data.status.present ? data.status.value : this.status,
      protonFileId: data.protonFileId.present
          ? data.protonFileId.value
          : this.protonFileId,
      sidecarSynced: data.sidecarSynced.present
          ? data.sidecarSynced.value
          : this.sidecarSynced,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatusTableData(')
          ..write('photoId: $photoId, ')
          ..write('status: $status, ')
          ..write('protonFileId: $protonFileId, ')
          ..write('sidecarSynced: $sidecarSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(photoId, status, protonFileId, sidecarSynced, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStatusTableData &&
          other.photoId == this.photoId &&
          other.status == this.status &&
          other.protonFileId == this.protonFileId &&
          other.sidecarSynced == this.sidecarSynced &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SyncStatusTableCompanion extends UpdateCompanion<SyncStatusTableData> {
  final Value<String> photoId;
  final Value<SyncStatus> status;
  final Value<String?> protonFileId;
  final Value<bool> sidecarSynced;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const SyncStatusTableCompanion({
    this.photoId = const Value.absent(),
    this.status = const Value.absent(),
    this.protonFileId = const Value.absent(),
    this.sidecarSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStatusTableCompanion.insert({
    required String photoId,
    required SyncStatus status,
    this.protonFileId = const Value.absent(),
    this.sidecarSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : photoId = Value(photoId),
        status = Value(status);
  static Insertable<SyncStatusTableData> custom({
    Expression<String>? photoId,
    Expression<String>? status,
    Expression<String>? protonFileId,
    Expression<bool>? sidecarSynced,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (photoId != null) 'photo_id': photoId,
      if (status != null) 'status': status,
      if (protonFileId != null) 'proton_file_id': protonFileId,
      if (sidecarSynced != null) 'sidecar_synced': sidecarSynced,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStatusTableCompanion copyWith(
      {Value<String>? photoId,
      Value<SyncStatus>? status,
      Value<String?>? protonFileId,
      Value<bool>? sidecarSynced,
      Value<DateTime?>? lastSyncedAt,
      Value<int>? rowid}) {
    return SyncStatusTableCompanion(
      photoId: photoId ?? this.photoId,
      status: status ?? this.status,
      protonFileId: protonFileId ?? this.protonFileId,
      sidecarSynced: sidecarSynced ?? this.sidecarSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (photoId.present) {
      map['photo_id'] = Variable<String>(photoId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $SyncStatusTableTable.$converterstatus.toSql(status.value));
    }
    if (protonFileId.present) {
      map['proton_file_id'] = Variable<String>(protonFileId.value);
    }
    if (sidecarSynced.present) {
      map['sidecar_synced'] = Variable<bool>(sidecarSynced.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatusTableCompanion(')
          ..write('photoId: $photoId, ')
          ..write('status: $status, ')
          ..write('protonFileId: $protonFileId, ')
          ..write('sidecarSynced: $sidecarSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PhotosTable photos = $PhotosTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $PhotoTagsTable photoTags = $PhotoTagsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $PhotoCategoriesTable photoCategories =
      $PhotoCategoriesTable(this);
  late final $AlbumsTable albums = $AlbumsTable(this);
  late final $AlbumPhotosTable albumPhotos = $AlbumPhotosTable(this);
  late final $SyncStatusTableTable syncStatusTable =
      $SyncStatusTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        photos,
        tags,
        photoTags,
        categories,
        photoCategories,
        albums,
        albumPhotos,
        syncStatusTable
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('photos',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('photo_tags', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tags',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('photo_tags', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('photos',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('photo_categories', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('photo_categories', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('albums',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('album_photos', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('photos',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('album_photos', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('photos',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('sync_status_table', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$PhotosTableCreateCompanionBuilder = PhotosCompanion Function({
  required String id,
  required String path,
  required String filename,
  required MediaType mediaType,
  required String sha256Hash,
  Value<String?> perceptualHash,
  required int sizeBytes,
  Value<int?> width,
  Value<int?> height,
  required String format,
  Value<int?> durationMs,
  Value<String?> codec,
  Value<double?> fps,
  Value<DateTime?> takenAt,
  Value<DateTime?> deletedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$PhotosTableUpdateCompanionBuilder = PhotosCompanion Function({
  Value<String> id,
  Value<String> path,
  Value<String> filename,
  Value<MediaType> mediaType,
  Value<String> sha256Hash,
  Value<String?> perceptualHash,
  Value<int> sizeBytes,
  Value<int?> width,
  Value<int?> height,
  Value<String> format,
  Value<int?> durationMs,
  Value<String?> codec,
  Value<double?> fps,
  Value<DateTime?> takenAt,
  Value<DateTime?> deletedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$PhotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhotosTable,
    Photo,
    $$PhotosTableFilterComposer,
    $$PhotosTableOrderingComposer,
    $$PhotosTableCreateCompanionBuilder,
    $$PhotosTableUpdateCompanionBuilder> {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PhotosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PhotosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String> filename = const Value.absent(),
            Value<MediaType> mediaType = const Value.absent(),
            Value<String> sha256Hash = const Value.absent(),
            Value<String?> perceptualHash = const Value.absent(),
            Value<int> sizeBytes = const Value.absent(),
            Value<int?> width = const Value.absent(),
            Value<int?> height = const Value.absent(),
            Value<String> format = const Value.absent(),
            Value<int?> durationMs = const Value.absent(),
            Value<String?> codec = const Value.absent(),
            Value<double?> fps = const Value.absent(),
            Value<DateTime?> takenAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotosCompanion(
            id: id,
            path: path,
            filename: filename,
            mediaType: mediaType,
            sha256Hash: sha256Hash,
            perceptualHash: perceptualHash,
            sizeBytes: sizeBytes,
            width: width,
            height: height,
            format: format,
            durationMs: durationMs,
            codec: codec,
            fps: fps,
            takenAt: takenAt,
            deletedAt: deletedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String path,
            required String filename,
            required MediaType mediaType,
            required String sha256Hash,
            Value<String?> perceptualHash = const Value.absent(),
            required int sizeBytes,
            Value<int?> width = const Value.absent(),
            Value<int?> height = const Value.absent(),
            required String format,
            Value<int?> durationMs = const Value.absent(),
            Value<String?> codec = const Value.absent(),
            Value<double?> fps = const Value.absent(),
            Value<DateTime?> takenAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotosCompanion.insert(
            id: id,
            path: path,
            filename: filename,
            mediaType: mediaType,
            sha256Hash: sha256Hash,
            perceptualHash: perceptualHash,
            sizeBytes: sizeBytes,
            width: width,
            height: height,
            format: format,
            durationMs: durationMs,
            codec: codec,
            fps: fps,
            takenAt: takenAt,
            deletedAt: deletedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$PhotosTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get path => $state.composableBuilder(
      column: $state.table.path,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get filename => $state.composableBuilder(
      column: $state.table.filename,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<MediaType, MediaType, String> get mediaType =>
      $state.composableBuilder(
          column: $state.table.mediaType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get sha256Hash => $state.composableBuilder(
      column: $state.table.sha256Hash,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get perceptualHash => $state.composableBuilder(
      column: $state.table.perceptualHash,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sizeBytes => $state.composableBuilder(
      column: $state.table.sizeBytes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get width => $state.composableBuilder(
      column: $state.table.width,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get height => $state.composableBuilder(
      column: $state.table.height,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get format => $state.composableBuilder(
      column: $state.table.format,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get durationMs => $state.composableBuilder(
      column: $state.table.durationMs,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codec => $state.composableBuilder(
      column: $state.table.codec,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get fps => $state.composableBuilder(
      column: $state.table.fps,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get takenAt => $state.composableBuilder(
      column: $state.table.takenAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter photoTagsRefs(
      ComposableFilter Function($$PhotoTagsTableFilterComposer f) f) {
    final $$PhotoTagsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.photoTags,
        getReferencedColumn: (t) => t.photoId,
        builder: (joinBuilder, parentComposers) =>
            $$PhotoTagsTableFilterComposer(ComposerState(
                $state.db, $state.db.photoTags, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter photoCategoriesRefs(
      ComposableFilter Function($$PhotoCategoriesTableFilterComposer f) f) {
    final $$PhotoCategoriesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.photoCategories,
            getReferencedColumn: (t) => t.photoId,
            builder: (joinBuilder, parentComposers) =>
                $$PhotoCategoriesTableFilterComposer(ComposerState($state.db,
                    $state.db.photoCategories, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter albumPhotosRefs(
      ComposableFilter Function($$AlbumPhotosTableFilterComposer f) f) {
    final $$AlbumPhotosTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.albumPhotos,
        getReferencedColumn: (t) => t.photoId,
        builder: (joinBuilder, parentComposers) =>
            $$AlbumPhotosTableFilterComposer(ComposerState($state.db,
                $state.db.albumPhotos, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter syncStatusTableRefs(
      ComposableFilter Function($$SyncStatusTableTableFilterComposer f) f) {
    final $$SyncStatusTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.syncStatusTable,
            getReferencedColumn: (t) => t.photoId,
            builder: (joinBuilder, parentComposers) =>
                $$SyncStatusTableTableFilterComposer(ComposerState($state.db,
                    $state.db.syncStatusTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$PhotosTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get path => $state.composableBuilder(
      column: $state.table.path,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get filename => $state.composableBuilder(
      column: $state.table.filename,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mediaType => $state.composableBuilder(
      column: $state.table.mediaType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sha256Hash => $state.composableBuilder(
      column: $state.table.sha256Hash,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get perceptualHash => $state.composableBuilder(
      column: $state.table.perceptualHash,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sizeBytes => $state.composableBuilder(
      column: $state.table.sizeBytes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get width => $state.composableBuilder(
      column: $state.table.width,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get height => $state.composableBuilder(
      column: $state.table.height,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get format => $state.composableBuilder(
      column: $state.table.format,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get durationMs => $state.composableBuilder(
      column: $state.table.durationMs,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codec => $state.composableBuilder(
      column: $state.table.codec,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get fps => $state.composableBuilder(
      column: $state.table.fps,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get takenAt => $state.composableBuilder(
      column: $state.table.takenAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  required String id,
  required String name,
  Value<String?> color,
  required TagSource source,
  Value<int> rowid,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> color,
  Value<TagSource> source,
  Value<int> rowid,
});

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TagsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<TagSource> source = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            name: name,
            color: color,
            source: source,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> color = const Value.absent(),
            required TagSource source,
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion.insert(
            id: id,
            name: name,
            color: color,
            source: source,
            rowid: rowid,
          ),
        ));
}

class $$TagsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<TagSource, TagSource, String> get source =>
      $state.composableBuilder(
          column: $state.table.source,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ComposableFilter photoTagsRefs(
      ComposableFilter Function($$PhotoTagsTableFilterComposer f) f) {
    final $$PhotoTagsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.photoTags,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder, parentComposers) =>
            $$PhotoTagsTableFilterComposer(ComposerState(
                $state.db, $state.db.photoTags, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$TagsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get source => $state.composableBuilder(
      column: $state.table.source,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PhotoTagsTableCreateCompanionBuilder = PhotoTagsCompanion Function({
  required String photoId,
  required String tagId,
  Value<double?> confidence,
  required TagSource source,
  Value<int> rowid,
});
typedef $$PhotoTagsTableUpdateCompanionBuilder = PhotoTagsCompanion Function({
  Value<String> photoId,
  Value<String> tagId,
  Value<double?> confidence,
  Value<TagSource> source,
  Value<int> rowid,
});

class $$PhotoTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhotoTagsTable,
    PhotoTag,
    $$PhotoTagsTableFilterComposer,
    $$PhotoTagsTableOrderingComposer,
    $$PhotoTagsTableCreateCompanionBuilder,
    $$PhotoTagsTableUpdateCompanionBuilder> {
  $$PhotoTagsTableTableManager(_$AppDatabase db, $PhotoTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PhotoTagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PhotoTagsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> photoId = const Value.absent(),
            Value<String> tagId = const Value.absent(),
            Value<double?> confidence = const Value.absent(),
            Value<TagSource> source = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotoTagsCompanion(
            photoId: photoId,
            tagId: tagId,
            confidence: confidence,
            source: source,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String photoId,
            required String tagId,
            Value<double?> confidence = const Value.absent(),
            required TagSource source,
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotoTagsCompanion.insert(
            photoId: photoId,
            tagId: tagId,
            confidence: confidence,
            source: source,
            rowid: rowid,
          ),
        ));
}

class $$PhotoTagsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PhotoTagsTable> {
  $$PhotoTagsTableFilterComposer(super.$state);
  ColumnFilters<double> get confidence => $state.composableBuilder(
      column: $state.table.confidence,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<TagSource, TagSource, String> get source =>
      $state.composableBuilder(
          column: $state.table.source,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  $$PhotosTableFilterComposer get photoId {
    final $$PhotosTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $state.db.photos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$PhotosTableFilterComposer(
            ComposerState(
                $state.db, $state.db.photos, joinBuilder, parentComposers)));
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $state.db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$TagsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.tags, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PhotoTagsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PhotoTagsTable> {
  $$PhotoTagsTableOrderingComposer(super.$state);
  ColumnOrderings<double> get confidence => $state.composableBuilder(
      column: $state.table.confidence,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get source => $state.composableBuilder(
      column: $state.table.source,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PhotosTableOrderingComposer get photoId {
    final $$PhotosTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $state.db.photos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PhotosTableOrderingComposer(ComposerState(
                $state.db, $state.db.photos, joinBuilder, parentComposers)));
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $state.db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$TagsTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.tags, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CategoriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CategoriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
        ));
}

class $$CategoriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter photoCategoriesRefs(
      ComposableFilter Function($$PhotoCategoriesTableFilterComposer f) f) {
    final $$PhotoCategoriesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.photoCategories,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder, parentComposers) =>
                $$PhotoCategoriesTableFilterComposer(ComposerState($state.db,
                    $state.db.photoCategories, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PhotoCategoriesTableCreateCompanionBuilder = PhotoCategoriesCompanion
    Function({
  required String photoId,
  required String categoryId,
  Value<double?> confidence,
  Value<int> rowid,
});
typedef $$PhotoCategoriesTableUpdateCompanionBuilder = PhotoCategoriesCompanion
    Function({
  Value<String> photoId,
  Value<String> categoryId,
  Value<double?> confidence,
  Value<int> rowid,
});

class $$PhotoCategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhotoCategoriesTable,
    PhotoCategory,
    $$PhotoCategoriesTableFilterComposer,
    $$PhotoCategoriesTableOrderingComposer,
    $$PhotoCategoriesTableCreateCompanionBuilder,
    $$PhotoCategoriesTableUpdateCompanionBuilder> {
  $$PhotoCategoriesTableTableManager(
      _$AppDatabase db, $PhotoCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PhotoCategoriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PhotoCategoriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> photoId = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<double?> confidence = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotoCategoriesCompanion(
            photoId: photoId,
            categoryId: categoryId,
            confidence: confidence,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String photoId,
            required String categoryId,
            Value<double?> confidence = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotoCategoriesCompanion.insert(
            photoId: photoId,
            categoryId: categoryId,
            confidence: confidence,
            rowid: rowid,
          ),
        ));
}

class $$PhotoCategoriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PhotoCategoriesTable> {
  $$PhotoCategoriesTableFilterComposer(super.$state);
  ColumnFilters<double> get confidence => $state.composableBuilder(
      column: $state.table.confidence,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PhotosTableFilterComposer get photoId {
    final $$PhotosTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $state.db.photos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$PhotosTableFilterComposer(
            ComposerState(
                $state.db, $state.db.photos, joinBuilder, parentComposers)));
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $state.db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriesTableFilterComposer(ComposerState($state.db,
                $state.db.categories, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PhotoCategoriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PhotoCategoriesTable> {
  $$PhotoCategoriesTableOrderingComposer(super.$state);
  ColumnOrderings<double> get confidence => $state.composableBuilder(
      column: $state.table.confidence,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PhotosTableOrderingComposer get photoId {
    final $$PhotosTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $state.db.photos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PhotosTableOrderingComposer(ComposerState(
                $state.db, $state.db.photos, joinBuilder, parentComposers)));
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $state.db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriesTableOrderingComposer(ComposerState($state.db,
                $state.db.categories, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$AlbumsTableCreateCompanionBuilder = AlbumsCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<bool> isHidden,
  Value<String?> coverPhotoId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$AlbumsTableUpdateCompanionBuilder = AlbumsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<bool> isHidden,
  Value<String?> coverPhotoId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$AlbumsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlbumsTable,
    Album,
    $$AlbumsTableFilterComposer,
    $$AlbumsTableOrderingComposer,
    $$AlbumsTableCreateCompanionBuilder,
    $$AlbumsTableUpdateCompanionBuilder> {
  $$AlbumsTableTableManager(_$AppDatabase db, $AlbumsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AlbumsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AlbumsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isHidden = const Value.absent(),
            Value<String?> coverPhotoId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumsCompanion(
            id: id,
            name: name,
            description: description,
            isHidden: isHidden,
            coverPhotoId: coverPhotoId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<bool> isHidden = const Value.absent(),
            Value<String?> coverPhotoId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumsCompanion.insert(
            id: id,
            name: name,
            description: description,
            isHidden: isHidden,
            coverPhotoId: coverPhotoId,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$AlbumsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isHidden => $state.composableBuilder(
      column: $state.table.isHidden,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get coverPhotoId => $state.composableBuilder(
      column: $state.table.coverPhotoId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter albumPhotosRefs(
      ComposableFilter Function($$AlbumPhotosTableFilterComposer f) f) {
    final $$AlbumPhotosTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.albumPhotos,
        getReferencedColumn: (t) => t.albumId,
        builder: (joinBuilder, parentComposers) =>
            $$AlbumPhotosTableFilterComposer(ComposerState($state.db,
                $state.db.albumPhotos, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$AlbumsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isHidden => $state.composableBuilder(
      column: $state.table.isHidden,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get coverPhotoId => $state.composableBuilder(
      column: $state.table.coverPhotoId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AlbumPhotosTableCreateCompanionBuilder = AlbumPhotosCompanion
    Function({
  required String albumId,
  required String photoId,
  required int position,
  Value<int> rowid,
});
typedef $$AlbumPhotosTableUpdateCompanionBuilder = AlbumPhotosCompanion
    Function({
  Value<String> albumId,
  Value<String> photoId,
  Value<int> position,
  Value<int> rowid,
});

class $$AlbumPhotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlbumPhotosTable,
    AlbumPhoto,
    $$AlbumPhotosTableFilterComposer,
    $$AlbumPhotosTableOrderingComposer,
    $$AlbumPhotosTableCreateCompanionBuilder,
    $$AlbumPhotosTableUpdateCompanionBuilder> {
  $$AlbumPhotosTableTableManager(_$AppDatabase db, $AlbumPhotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AlbumPhotosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AlbumPhotosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> albumId = const Value.absent(),
            Value<String> photoId = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumPhotosCompanion(
            albumId: albumId,
            photoId: photoId,
            position: position,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String albumId,
            required String photoId,
            required int position,
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumPhotosCompanion.insert(
            albumId: albumId,
            photoId: photoId,
            position: position,
            rowid: rowid,
          ),
        ));
}

class $$AlbumPhotosTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AlbumPhotosTable> {
  $$AlbumPhotosTableFilterComposer(super.$state);
  ColumnFilters<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$AlbumsTableFilterComposer get albumId {
    final $$AlbumsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.albumId,
        referencedTable: $state.db.albums,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$AlbumsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.albums, joinBuilder, parentComposers)));
    return composer;
  }

  $$PhotosTableFilterComposer get photoId {
    final $$PhotosTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $state.db.photos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$PhotosTableFilterComposer(
            ComposerState(
                $state.db, $state.db.photos, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$AlbumPhotosTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AlbumPhotosTable> {
  $$AlbumPhotosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$AlbumsTableOrderingComposer get albumId {
    final $$AlbumsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.albumId,
        referencedTable: $state.db.albums,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$AlbumsTableOrderingComposer(ComposerState(
                $state.db, $state.db.albums, joinBuilder, parentComposers)));
    return composer;
  }

  $$PhotosTableOrderingComposer get photoId {
    final $$PhotosTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $state.db.photos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PhotosTableOrderingComposer(ComposerState(
                $state.db, $state.db.photos, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$SyncStatusTableTableCreateCompanionBuilder = SyncStatusTableCompanion
    Function({
  required String photoId,
  required SyncStatus status,
  Value<String?> protonFileId,
  Value<bool> sidecarSynced,
  Value<DateTime?> lastSyncedAt,
  Value<int> rowid,
});
typedef $$SyncStatusTableTableUpdateCompanionBuilder = SyncStatusTableCompanion
    Function({
  Value<String> photoId,
  Value<SyncStatus> status,
  Value<String?> protonFileId,
  Value<bool> sidecarSynced,
  Value<DateTime?> lastSyncedAt,
  Value<int> rowid,
});

class $$SyncStatusTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncStatusTableTable,
    SyncStatusTableData,
    $$SyncStatusTableTableFilterComposer,
    $$SyncStatusTableTableOrderingComposer,
    $$SyncStatusTableTableCreateCompanionBuilder,
    $$SyncStatusTableTableUpdateCompanionBuilder> {
  $$SyncStatusTableTableTableManager(
      _$AppDatabase db, $SyncStatusTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SyncStatusTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SyncStatusTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> photoId = const Value.absent(),
            Value<SyncStatus> status = const Value.absent(),
            Value<String?> protonFileId = const Value.absent(),
            Value<bool> sidecarSynced = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncStatusTableCompanion(
            photoId: photoId,
            status: status,
            protonFileId: protonFileId,
            sidecarSynced: sidecarSynced,
            lastSyncedAt: lastSyncedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String photoId,
            required SyncStatus status,
            Value<String?> protonFileId = const Value.absent(),
            Value<bool> sidecarSynced = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncStatusTableCompanion.insert(
            photoId: photoId,
            status: status,
            protonFileId: protonFileId,
            sidecarSynced: sidecarSynced,
            lastSyncedAt: lastSyncedAt,
            rowid: rowid,
          ),
        ));
}

class $$SyncStatusTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SyncStatusTableTable> {
  $$SyncStatusTableTableFilterComposer(super.$state);
  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String> get status =>
      $state.composableBuilder(
          column: $state.table.status,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get protonFileId => $state.composableBuilder(
      column: $state.table.protonFileId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get sidecarSynced => $state.composableBuilder(
      column: $state.table.sidecarSynced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastSyncedAt => $state.composableBuilder(
      column: $state.table.lastSyncedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PhotosTableFilterComposer get photoId {
    final $$PhotosTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $state.db.photos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$PhotosTableFilterComposer(
            ComposerState(
                $state.db, $state.db.photos, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$SyncStatusTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SyncStatusTableTable> {
  $$SyncStatusTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get protonFileId => $state.composableBuilder(
      column: $state.table.protonFileId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get sidecarSynced => $state.composableBuilder(
      column: $state.table.sidecarSynced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastSyncedAt => $state.composableBuilder(
      column: $state.table.lastSyncedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PhotosTableOrderingComposer get photoId {
    final $$PhotosTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.photoId,
        referencedTable: $state.db.photos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PhotosTableOrderingComposer(ComposerState(
                $state.db, $state.db.photos, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$PhotoTagsTableTableManager get photoTags =>
      $$PhotoTagsTableTableManager(_db, _db.photoTags);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$PhotoCategoriesTableTableManager get photoCategories =>
      $$PhotoCategoriesTableTableManager(_db, _db.photoCategories);
  $$AlbumsTableTableManager get albums =>
      $$AlbumsTableTableManager(_db, _db.albums);
  $$AlbumPhotosTableTableManager get albumPhotos =>
      $$AlbumPhotosTableTableManager(_db, _db.albumPhotos);
  $$SyncStatusTableTableTableManager get syncStatusTable =>
      $$SyncStatusTableTableTableManager(_db, _db.syncStatusTable);
}
