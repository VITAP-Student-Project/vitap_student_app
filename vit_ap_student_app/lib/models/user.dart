import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart'; // Correct file name

@JsonSerializable()
class Post {
  String id;
  String content;
  String profileImagePath;
  String username;
  DateTime timestamp;
  String type;
  int likes;
  int dislikes;
  List<String> likedBy;
  List<String> dislikedBy;
  List<Comment> comments;
  List<String> tags;
  String creatorId; // New field to store the ID of the creator

  Post({
    required this.id,
    required this.content,
    required this.profileImagePath,
    required this.username,
    required this.timestamp,
    required this.type,
    required this.likes,
    required this.dislikes,
    required this.likedBy,
    required this.dislikedBy,
    required this.comments,
    required this.tags,
    required this.creatorId, // Initialize the new field
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    String? id,
    String? content,
    String? profileImagePath,
    String? username,
    DateTime? timestamp,
    String? type,
    int? likes,
    int? dislikes,
    List<String>? likedBy,
    List<String>? dislikedBy,
    List<Comment>? comments,
    List<String>? tags,
    String? creatorId, // Add the new field to copyWith
  }) {
    return Post(
      id: id ?? this.id,
      content: content ?? this.content,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      username: username ?? this.username,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      likedBy: likedBy ?? this.likedBy,
      dislikedBy: dislikedBy ?? this.dislikedBy,
      comments: comments ?? this.comments,
      tags: tags ?? this.tags,
      creatorId: creatorId ?? this.creatorId, // Handle the new field
    );
  }
}

@JsonSerializable()
class Comment {
  String id;
  String content;
  String userId;
  String profileImagePath;
  int likes;
  List<String> likedBy;
  DateTime timestamp;

  Comment({
    required this.id,
    required this.content,
    required this.userId,
    required this.profileImagePath,
    required this.likes,
    required this.likedBy,
    required this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment copyWith({
    String? id,
    String? content,
    String? userId,
    String? profileImagePath,
    int? likes,
    List<String>? likedBy,
    DateTime? timestamp,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      likes: likes ?? this.likes,
      likedBy: likedBy ?? this.likedBy,
      timestamp: timestamp ?? this.timestamp, // Update this field
    );
  }
}

@JsonSerializable()
class Student {
  String name;
  String regNo;
  String profileImagePath;
  Map<String, dynamic> timetable;
  Map<String, dynamic> examSchedule;
  Map<String, dynamic> attendance;
  List<Map<String, dynamic>> marks;
  bool isNotificationsEnabled;
  bool isPrivacyModeEnabled;
  int notificationDelay;
  Map<String, dynamic> profile;

  Student({
    required this.name,
    required this.regNo,
    required this.profileImagePath,
    required this.timetable,
    required this.examSchedule,
    required this.attendance,
    required this.marks,
    required this.isNotificationsEnabled,
    required this.isPrivacyModeEnabled,
    required this.notificationDelay,
    required this.profile,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  Student copyWith({
    String? name,
    String? regNo,
    String? profileImagePath,
    Map<String, dynamic>? timetable,
    Map<String, dynamic>? examSchedule,
    Map<String, dynamic>? attendance,
    List<Map<String, dynamic>>? marks,
    bool? isNotificationsEnabled,
    bool? isPrivacyModeEnabled,
    int? notificationDelay,
    Map<String, dynamic>? profile,
  }) {
    return Student(
      name: name ?? this.name,
      regNo: regNo ?? this.regNo,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      timetable: timetable ?? this.timetable,
      examSchedule: examSchedule ?? this.examSchedule,
      attendance: attendance ?? this.attendance,
      marks: marks ?? this.marks,
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
      isPrivacyModeEnabled: isPrivacyModeEnabled ?? this.isPrivacyModeEnabled,
      notificationDelay: notificationDelay ?? this.notificationDelay,
      profile: profile ?? this.profile,
    );
  }
}
