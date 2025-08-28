// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      importance: json['importance'] as String,
      createdAt: json['createdAt'] as String,
      expiresAt: json['expiresAt'] as String,
      isActive: json['isActive'] as bool,
      actionUrl: json['actionUrl'] as String?,
      actionText: json['actionText'] as String?,
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'importance': instance.importance,
      'createdAt': instance.createdAt,
      'expiresAt': instance.expiresAt,
      'isActive': instance.isActive,
      'actionUrl': instance.actionUrl,
      'actionText': instance.actionText,
    };

AnnouncementResponse _$AnnouncementResponseFromJson(
        Map<String, dynamic> json) =>
    AnnouncementResponse(
      version: json['version'] as String,
      lastUpdated: json['lastUpdated'] as String,
      announcements: (json['announcements'] as List<dynamic>)
          .map((e) => Announcement.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: AnnouncementMetadata.fromJson(
          json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnnouncementResponseToJson(
        AnnouncementResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'lastUpdated': instance.lastUpdated,
      'announcements': instance.announcements,
      'metadata': instance.metadata,
    };

AnnouncementMetadata _$AnnouncementMetadataFromJson(
        Map<String, dynamic> json) =>
    AnnouncementMetadata(
      supportedTypes: (json['supportedTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      importanceLevels: (json['importanceLevels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      maxActiveAnnouncements: (json['maxActiveAnnouncements'] as num).toInt(),
    );

Map<String, dynamic> _$AnnouncementMetadataToJson(
        AnnouncementMetadata instance) =>
    <String, dynamic>{
      'supportedTypes': instance.supportedTypes,
      'importanceLevels': instance.importanceLevels,
      'maxActiveAnnouncements': instance.maxActiveAnnouncements,
    };
