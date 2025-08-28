import 'package:json_annotation/json_annotation.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "type")
  final String type;

  @JsonKey(name: "importance")
  final String importance;

  @JsonKey(name: "createdAt")
  final String createdAt;

  @JsonKey(name: "expiresAt")
  final String expiresAt;

  @JsonKey(name: "isActive")
  final bool isActive;

  @JsonKey(name: "actionUrl")
  final String? actionUrl;

  @JsonKey(name: "actionText")
  final String? actionText;

  const Announcement({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.importance,
    required this.createdAt,
    required this.expiresAt,
    required this.isActive,
    this.actionUrl,
    this.actionText,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}

@JsonSerializable()
class AnnouncementResponse {
  @JsonKey(name: "version")
  final String version;

  @JsonKey(name: "lastUpdated")
  final String lastUpdated;

  @JsonKey(name: "announcements")
  final List<Announcement> announcements;

  @JsonKey(name: "metadata")
  final AnnouncementMetadata metadata;

  const AnnouncementResponse({
    required this.version,
    required this.lastUpdated,
    required this.announcements,
    required this.metadata,
  });

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementResponseToJson(this);
}

@JsonSerializable()
class AnnouncementMetadata {
  @JsonKey(name: "supportedTypes")
  final List<String> supportedTypes;

  @JsonKey(name: "importanceLevels")
  final List<String> importanceLevels;

  @JsonKey(name: "maxActiveAnnouncements")
  final int maxActiveAnnouncements;

  const AnnouncementMetadata({
    required this.supportedTypes,
    required this.importanceLevels,
    required this.maxActiveAnnouncements,
  });

  factory AnnouncementMetadata.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementMetadataToJson(this);
}
