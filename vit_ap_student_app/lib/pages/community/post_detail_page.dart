import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../models/user/User.dart';
import '../../utils/provider/community_provider.dart';

class PostDetailPage extends ConsumerStatefulWidget {
  final Post post;
  final String userId;

  const PostDetailPage({super.key, required this.post, required this.userId});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void _addCommentLike(
      WidgetRef ref, String postId, String commentId, String userId) async {
    await ref
        .read(postsProvider.notifier)
        .likeComment(postId, commentId, userId);
  }

  void _editPost(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Post'),
        content: TextField(
          controller: TextEditingController(text: post.content),
          decoration: const InputDecoration(
            hintText: 'Edit your post...',
          ),
          onChanged: (value) {
            post = post.copyWith(content: value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(postsProvider.notifier).updatePost(post);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deletePost(BuildContext context, String postId) async {
    final confirmation = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmation == true) {
      await ref.read(postsProvider.notifier).deletePost(postId);
      Navigator.of(context).pop(); // Navigate back
    }
  }

  @override
  Widget build(BuildContext context) {
    final post =
        ref.watch(postsProvider).firstWhere((p) => p.id == widget.post.id);
    final isPostOwner = widget.userId ==
        post.username; // Ensure this matches your criteria for ownership

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post header
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(post.profileImagePath),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        _formatTimestamp(post.timestamp),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (isPostOwner) // Conditionally show edit and delete buttons
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editPost(context, post),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deletePost(context, post.id),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.content),
            const SizedBox(height: 8),
            // Interaction buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildInteractionButton(
                  context,
                  ref,
                  icon: Icons.thumb_up,
                  count: post.likes,
                  isActive: post.likedBy.contains(widget.userId),
                  onPressed: () => _likePost(ref, post.id, widget.userId),
                ),
                _buildInteractionButton(
                  context,
                  ref,
                  icon: Icons.thumb_down,
                  count: post.dislikes,
                  isActive: post.dislikedBy.contains(widget.userId),
                  onPressed: () => _dislikePost(ref, post.id, widget.userId),
                ),
              ],
            ),
            const Divider(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Theme.of(context).colorScheme.secondary),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
                      child: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Add a comment...',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      _addComment(ref, post.id, commentController.text);
                      commentController.clear();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Comments section
            ...post.comments.map(
              (comment) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(comment.profileImagePath),
                ),
                title: Text(comment.userId),
                subtitle: Text(comment.content),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () => _addCommentLike(
                          ref, post.id, comment.id, widget.userId),
                    ),
                    Text(comment.likes.toString()),
                  ],
                ),
              ),
            ),

            // Comment input
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionButton(
    BuildContext context,
    WidgetRef ref, {
    required IconData icon,
    required int count,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return Row(
      children: [
        IconButton(
          icon: Icon(icon,
              color: isActive ? Theme.of(context).colorScheme.primary : null),
          onPressed: onPressed,
        ),
        Text(count.toString()),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return timeago.format(timestamp);
  }

  void _likePost(WidgetRef ref, String postId, String userId) async {
    await ref.read(postsProvider.notifier).likePost(postId, userId);
  }

  void _dislikePost(WidgetRef ref, String postId, String userId) async {
    await ref.read(postsProvider.notifier).dislikePost(postId, userId);
  }

  Future<void> _addComment(
      WidgetRef ref, String postId, String commentText) async {
    if (commentText.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final profileImagePath =
        prefs.getString('pfpPath') ?? 'assets/images/pfp/default.jpg';
    final newComment = Comment(
      id: '', // This will be set by Firestore
      userId: widget.userId,
      content: commentText,
      timestamp: DateTime.now(),
      profileImagePath: profileImagePath,
      likes: 0,
      likedBy: [],
    );

    await ref.read(postsProvider.notifier).addComment(postId, newComment);
    commentController.clear(); // Clear the comment input field
  }
}
