// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'for_you_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForYouItem _$ForYouItemFromJson(Map<String, dynamic> json) => ForYouItem(
  id: json['id'] as String,
  title: json['title'] as String,
  author: json['author'] as String,
  authorEmail: json['author_email'] as String,
  imageUrl: json['image_url'] as String?,
  type: json['type'] as String,
  description: json['description'] as String,
  url: json['url'] as String,
  note: json['note'] as String?,
  requires: json['requires'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  isActive: json['is_active'] as bool? ?? true,
  verified: json['verified'] as bool? ?? false,
  isApproved: json['is_approved'] as bool,
  isFeatured: json['is_featured'] as bool,
  displayOrder: (json['display_order'] as num).toInt(),
  likes: (json['likes'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$ForYouItemToJson(ForYouItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'author_email': instance.authorEmail,
      'image_url': instance.imageUrl,
      'type': instance.type,
      'description': instance.description,
      'url': instance.url,
      'note': instance.note,
      'requires': instance.requires,
      'tags': instance.tags,
      'is_active': instance.isActive,
      'verified': instance.verified,
      'is_approved': instance.isApproved,
      'is_featured': instance.isFeatured,
      'display_order': instance.displayOrder,
      'likes': instance.likes,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

ForYouItemSubmission _$ForYouItemSubmissionFromJson(
  Map<String, dynamic> json,
) => ForYouItemSubmission(
  title: json['title'] as String,
  author: json['author'] as String,
  authorEmail: json['author_email'] as String,
  imageUrl: json['image_url'] as String?,
  type: json['type'] as String,
  description: json['description'] as String,
  url: json['url'] as String,
  note: json['note'] as String?,
  requires: json['requires'] as String?,
);

Map<String, dynamic> _$ForYouItemSubmissionToJson(
  ForYouItemSubmission instance,
) => <String, dynamic>{
  'title': instance.title,
  'author': instance.author,
  'author_email': instance.authorEmail,
  'image_url': instance.imageUrl,
  'type': instance.type,
  'description': instance.description,
  'url': instance.url,
  'note': instance.note,
  'requires': instance.requires,
};
