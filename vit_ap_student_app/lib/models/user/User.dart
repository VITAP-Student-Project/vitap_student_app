import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart'; // Make sure to run build_runner to generate this file

@JsonSerializable()
class Post {
  final String id;
  final String username;
  final String profileImagePath;
  final String content;
  final String type; // 'text', 'link', 'image', 'audio', 'video'
  final int likes;
  final int dislikes;
  final List<Comment> comments;
  final DateTime timestamp;
  final List<String> likedBy; // List of user IDs who liked the post
  final List<String> dislikedBy; // List of user IDs who disliked the post

  Post({
    required this.id,
    required this.username,
    required this.profileImagePath,
    required this.content,
    required this.type,
    required this.likes,
    required this.dislikes,
    required this.comments,
    required this.timestamp,
    required this.likedBy,
    required this.dislikedBy,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    String? id,
    String? username,
    String? profileImagePath,
    String? content,
    String? type,
    int? likes,
    int? dislikes,
    List<Comment>? comments,
    DateTime? timestamp,
    List<String>? likedBy,
    List<String>? dislikedBy,
  }) {
    return Post(
      id: id ?? this.id,
      username: username ?? this.username,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      content: content ?? this.content,
      type: type ?? this.type,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      comments: comments ?? this.comments,
      timestamp: timestamp ?? this.timestamp,
      likedBy: likedBy ?? this.likedBy,
      dislikedBy: dislikedBy ?? this.dislikedBy,
    );
  }
}


@JsonSerializable()
class Comment {
  final String id;
  final String username;
  final String profileImagePath;
  final String content;
  final DateTime timestamp; // Add this field

  Comment({
    required this.id,
    required this.username,
    required this.profileImagePath,
    required this.content,
    required this.timestamp, // Initialize this field
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment copyWith({
    String? id,
    String? username,
    String? profileImagePath,
    String? content,
    DateTime? timestamp, // Add this field
  }) {
    return Comment(
      id: id ?? this.id,
      username: username ?? this.username,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp, // Update this field
    );
  }
}
