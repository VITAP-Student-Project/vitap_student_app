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
      isApproved: json['is_approved'] as bool,
      isFeatured: json['is_featured'] as bool,
      displayOrder: (json['display_order'] as num).toInt(),
      likes: (json['likes'] as num).toInt(),
      createdAt: json['created_at'] as String,
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
      'is_approved': instance.isApproved,
      'is_featured': instance.isFeatured,
      'display_order': instance.displayOrder,
      'likes': instance.likes,
      'created_at': instance.createdAt,
    };

ForYouItemSubmission _$ForYouItemSubmissionFromJson(
        Map<String, dynamic> json) =>
    ForYouItemSubmission(
      title: json['title'] as String,
      author: json['author'] as String,
      authorEmail: json['author_email'] as String,
      imageUrl: json['image_url'] as String?,
      type: json['type'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ForYouItemSubmissionToJson(
        ForYouItemSubmission instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'author_email': instance.authorEmail,
      'image_url': instance.imageUrl,
      'type': instance.type,
      'description': instance.description,
      'url': instance.url,
    };
