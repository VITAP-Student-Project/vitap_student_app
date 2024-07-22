import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';  // Make sure to run build_runner to generate this file

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

  Post({
    required this.id,
    required this.username,
    required this.profileImagePath,
    required this.content,
    required this.type,
    required this.likes,
    required this.dislikes,
    required this.comments,
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
    );
  }
}

@JsonSerializable()
class Comment {
  final String id;
  final String username;
  final String profileImagePath;
  final String content;

  Comment({
    required this.id,
    required this.username,
    required this.profileImagePath,
    required this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment copyWith({
    String? id,
    String? username,
    String? profileImagePath,
    String? content,
  }) {
    return Comment(
      id: id ?? this.id,
      username: username ?? this.username,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      content: content ?? this.content,
    );
  }
}

