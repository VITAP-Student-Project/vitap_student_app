import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vit_ap_student_app/pages/features/create_post.dart';

import '../../models/user/User.dart';
import '../../utils/provider/community_provider.dart';
import 'comment_dialogue.dart';

class CommunityPage extends ConsumerStatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  late Future<String> _userIdFuture;

  @override
  void initState() {
    super.initState();
    _userIdFuture = fetchUserRegNo();
    // Fetch posts in the background
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postsProvider.notifier).fetchPosts();
    });
  }

  Future<String> fetchUserRegNo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ??
        ''; // Return empty string if no userId found
  }

  Future<void> _refreshPosts() async {
    await ref.read(postsProvider.notifier).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreatePostDialog(context),
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: _userIdFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final userId = snapshot.data!;
            if (posts.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/images/lottie/empty.json",
                    frameRate: FrameRate(60),
                    width: 380,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      'No content here yet...',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                  Text(
                    'Post something awesome to get things started!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              );
            }
            return RefreshIndicator(
              onRefresh: _refreshPosts,
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostTile(
                    post: post,
                    userId: userId,
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('No user ID found'));
          }
        },
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreatePostDialog(),
    );
  }
}

class PostTile extends ConsumerWidget {
  final String userId;
  final Post post;

  PostTile({super.key, required this.post, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(post.profileImagePath)),
      title: Text(
        post.username,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.content),
          Text(
            _formatTimestamp(post.timestamp),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.thumb_up,
              color: post.likedBy.contains(userId) ? Colors.blue : null,
            ),
            onPressed: () => _likePost(ref, post.id, userId),
          ),
          Text(post.likes.toString()),
          IconButton(
            icon: Icon(
              Icons.thumb_down,
              color: post.dislikedBy.contains(userId) ? Colors.red : null,
            ),
            onPressed: () => _dislikePost(ref, post.id, userId),
          ),
          Text(post.dislikes.toString()),
          IconButton(
            icon: Icon(Icons.comment),
            onPressed: () => _commentOnPost(context, ref, post.id),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return timeago.format(timestamp);
  }

  void _likePost(WidgetRef ref, String postId, String userId) {
    ref.read(postsProvider.notifier).likePost(postId, userId);
  }

  void _dislikePost(WidgetRef ref, String postId, String userId) {
    ref.read(postsProvider.notifier).dislikePost(postId, userId);
  }

  void _commentOnPost(BuildContext context, WidgetRef ref, String postId) {
    showDialog(
      context: context,
      builder: (context) => CommentDialog(
        postId: postId,
        onCommentAdded: (comment) {
          ref.read(postsProvider.notifier).addComment(postId, comment);
        },
      ),
    );
  }
}
