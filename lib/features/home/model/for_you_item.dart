import 'package:json_annotation/json_annotation.dart';

part 'for_you_item.g.dart';

/// A prerequisite the reader has to satisfy before a tool is usable.
///
/// Sent as a plain string so the admin dashboard stays free-form; unknown
/// values decode to null rather than throwing, the same leniency
/// `announcements.json` gets, because this feed is hand-curated too.
enum ForYouRequirement {
  campusWifi('campus_wifi'),
  hostelWifi('hostel_wifi'),
  vtopLogin('vtop_login');

  const ForYouRequirement(this.wireName);

  final String wireName;

  static ForYouRequirement? fromWire(String? value) {
    if (value == null) return null;
    for (final requirement in ForYouRequirement.values) {
      if (requirement.wireName == value) return requirement;
    }
    return null;
  }
}

@JsonSerializable()
class ForYouItem {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'author')
  final String author;

  @JsonKey(name: 'author_email')
  final String authorEmail;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'url')
  final String url;

  /// Free-text caveat shown on the detail page, e.g. "results are only
  /// published after the term ends". Use [requires] instead for the recurring
  /// structured cases so the app owns the wording.
  @JsonKey(name: 'note')
  final String? note;

  /// Raw wire value; read [requirement] for the parsed form.
  @JsonKey(name: 'requires')
  final String? requires;

  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String> tags;

  /// Lets a dead link be retired without deleting the row and losing its likes.
  @JsonKey(name: 'is_active', defaultValue: true)
  final bool isActive;

  /// Maintainer has opened the link and checked it does what it claims. This is
  /// the visible counterpart to [isApproved], which only gates listing.
  @JsonKey(name: 'verified', defaultValue: false)
  final bool verified;

  @JsonKey(name: 'is_approved')
  final bool isApproved;

  @JsonKey(name: 'is_featured')
  final bool isFeatured;

  @JsonKey(name: 'display_order')
  final int displayOrder;

  @JsonKey(name: 'likes')
  final int likes;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  const ForYouItem({
    required this.id,
    required this.title,
    required this.author,
    required this.authorEmail,
    this.imageUrl,
    required this.type,
    required this.description,
    required this.url,
    this.note,
    this.requires,
    this.tags = const <String>[],
    this.isActive = true,
    this.verified = false,
    required this.isApproved,
    required this.isFeatured,
    required this.displayOrder,
    required this.likes,
    required this.createdAt,
    this.updatedAt,
  });

  /// Null when the feed carries no requirement, or one this build doesn't know.
  ForYouRequirement? get requirement => ForYouRequirement.fromWire(requires);

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
    String? note,
    String? requires,
    List<String>? tags,
    bool? isActive,
    bool? verified,
    bool? isApproved,
    bool? isFeatured,
    int? displayOrder,
    int? likes,
    String? createdAt,
    String? updatedAt,
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
      note: note ?? this.note,
      requires: requires ?? this.requires,
      tags: tags ?? this.tags,
      isActive: isActive ?? this.isActive,
      verified: verified ?? this.verified,
      isApproved: isApproved ?? this.isApproved,
      isFeatured: isFeatured ?? this.isFeatured,
      displayOrder: displayOrder ?? this.displayOrder,
      likes: likes ?? this.likes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Model for submitting a new item (without server-generated fields)
@JsonSerializable()
class ForYouItemSubmission {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'author')
  final String author;

  @JsonKey(name: 'author_email')
  final String authorEmail;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(name: 'requires')
  final String? requires;

  const ForYouItemSubmission({
    required this.title,
    required this.author,
    required this.authorEmail,
    this.imageUrl,
    required this.type,
    required this.description,
    required this.url,
    this.note,
    this.requires,
  });

  factory ForYouItemSubmission.fromJson(Map<String, dynamic> json) =>
      _$ForYouItemSubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$ForYouItemSubmissionToJson(this);
}
