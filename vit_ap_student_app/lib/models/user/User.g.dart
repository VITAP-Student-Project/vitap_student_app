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
      timestamp: DateTime.parse(json['timestamp'] as String),
      likedBy:
          (json['likedBy'] as List<dynamic>).map((e) => e as String).toList(),
      dislikedBy: (json['dislikedBy'] as List<dynamic>)
          .map((e) => e as String)
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
      'timestamp': instance.timestamp.toIso8601String(),
      'likedBy': instance.likedBy,
      'dislikedBy': instance.dislikedBy,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      username: json['username'] as String,
      profileImagePath: json['profileImagePath'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profileImagePath': instance.profileImagePath,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
    };
