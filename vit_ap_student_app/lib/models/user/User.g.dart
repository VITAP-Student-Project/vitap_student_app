// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      username: json['username'] as String,
      profileImagePath: json['profileImagePath'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      likes: (json['likes'] as num).toInt(),
      dislikes: (json['dislikes'] as num).toInt(),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profileImagePath': instance.profileImagePath,
      'content': instance.content,
      'type': instance.type,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'comments': instance.comments,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      username: json['username'] as String,
      profileImagePath: json['profileImagePath'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profileImagePath': instance.profileImagePath,
      'content': instance.content,
    };
