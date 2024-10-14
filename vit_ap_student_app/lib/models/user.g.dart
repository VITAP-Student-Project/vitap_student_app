// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

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

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      name: json['name'] as String,
      regNo: json['regNo'] as String,
      profileImagePath: json['profileImagePath'] as String,
      timetable: json['timetable'] as Map<String, dynamic>,
      examSchedule: json['examSchedule'] as Map<String, dynamic>,
      attendance: json['attendance'] as Map<String, dynamic>,
      marks: (json['marks'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      isNotificationsEnabled: json['isNotificationsEnabled'] as bool,
      isPrivacyModeEnabled: json['isPrivacyModeEnabled'] as bool,
      notificationDelay: (json['notificationDelay'] as num).toInt(),
      profile: json['profile'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'name': instance.name,
      'regNo': instance.regNo,
      'profileImagePath': instance.profileImagePath,
      'timetable': instance.timetable,
      'examSchedule': instance.examSchedule,
      'attendance': instance.attendance,
      'marks': instance.marks,
      'isNotificationsEnabled': instance.isNotificationsEnabled,
      'isPrivacyModeEnabled': instance.isPrivacyModeEnabled,
      'notificationDelay': instance.notificationDelay,
      'profile': instance.profile,
    };
