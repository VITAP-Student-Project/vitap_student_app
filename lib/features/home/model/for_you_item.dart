import 'package:json_annotation/json_annotation.dart';

part 'for_you_item.g.dart';

@JsonSerializable()
class ForYouItem {
  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "author")
  final String author;

  @JsonKey(name: "author_email")
  final String authorEmail;

  @JsonKey(name: "image_url")
  final String? imageUrl;

  @JsonKey(name: "type")
  final String type;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "url")
  final String url;

  @JsonKey(name: "is_approved")
  final bool isApproved;

  @JsonKey(name: "is_featured")
  final bool isFeatured;

  @JsonKey(name: "display_order")
  final int displayOrder;

  @JsonKey(name: "likes")
  final int likes;

  @JsonKey(name: "created_at")
  final String createdAt;

  const ForYouItem({
    required this.id,
    required this.title,
    required this.author,
    required this.authorEmail,
    this.imageUrl,
    required this.type,
    required this.description,
    required this.url,
    required this.isApproved,
    required this.isFeatured,
    required this.displayOrder,
    required this.likes,
    required this.createdAt,
  });

  factory ForYouItem.fromJson(Map<String, dynamic> json) =>
      _$ForYouItemFromJson(json);

  Map<String, dynamic> toJson() => _$ForYouItemToJson(this);

  /// Create a copy with updated likes
  ForYouItem copyWith({
    String? id,
    String? title,
    String? author,
    String? authorEmail,
    String? imageUrl,
    String? type,
    String? description,
    String? url,
    bool? isApproved,
    bool? isFeatured,
    int? displayOrder,
    int? likes,
    String? createdAt,
  }) {
    return ForYouItem(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      authorEmail: authorEmail ?? this.authorEmail,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      description: description ?? this.description,
      url: url ?? this.url,
      isApproved: isApproved ?? this.isApproved,
      isFeatured: isFeatured ?? this.isFeatured,
      displayOrder: displayOrder ?? this.displayOrder,
      likes: likes ?? this.likes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// Model for submitting a new item (without server-generated fields)
@JsonSerializable()
class ForYouItemSubmission {
  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "author")
  final String author;

  @JsonKey(name: "author_email")
  final String authorEmail;

  @JsonKey(name: "image_url")
  final String? imageUrl;

  @JsonKey(name: "type")
  final String type;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "url")
  final String url;

  const ForYouItemSubmission({
    required this.title,
    required this.author,
    required this.authorEmail,
    this.imageUrl,
    required this.type,
    required this.description,
    required this.url,
  });

  factory ForYouItemSubmission.fromJson(Map<String, dynamic> json) =>
      _$ForYouItemSubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$ForYouItemSubmissionToJson(this);
}
