// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      content: json['content'] as String,
      profileImagePath: json['profileImagePath'] as String,
      username: json['username'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: json['type'] as String,
      likes: (json['likes'] as num).toInt(),
      dislikes: (json['dislikes'] as num).toInt(),
      likedBy:
          (json['likedBy'] as List<dynamic>).map((e) => e as String).toList(),
      dislikedBy: (json['dislikedBy'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      creatorId: json['creatorId'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'profileImagePath': instance.profileImagePath,
      'username': instance.username,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': instance.type,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'likedBy': instance.likedBy,
      'dislikedBy': instance.dislikedBy,
      'comments': instance.comments,
      'tags': instance.tags,
      'creatorId': instance.creatorId,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      profileImagePath: json['profileImagePath'] as String,
      likes: (json['likes'] as num).toInt(),
      likedBy:
          (json['likedBy'] as List<dynamic>).map((e) => e as String).toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'userId': instance.userId,
      'profileImagePath': instance.profileImagePath,
      'likes': instance.likes,
      'likedBy': instance.likedBy,
      'timestamp': instance.timestamp.toIso8601String(),
    };
