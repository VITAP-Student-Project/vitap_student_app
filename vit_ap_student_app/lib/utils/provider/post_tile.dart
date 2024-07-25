import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user/User.dart';
import 'community_provider.dart';

class PostTile extends ConsumerWidget {
  final Post post;
  late String userId;
  void fetchUserRegNo() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('username') ??
        ''; // Return empty string if no userId found
  }

  PostTile({required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage(post.profileImagePath)),
                SizedBox(width: 8),
                Text(post.username,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Text(post.content),
            if (post.type == 'image') Image.network(post.content),
            if (post.type == 'audio') Text('Audio: ${post.content}'),
            if (post.type == 'video') Text('Video: ${post.content}'),
            if (post.type == 'link') Text('Link: ${post.content}'),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () => ref.read(postsProvider.notifier).likePost(
                        post.id,
                        userId,
                      ),
                ),
                Text('${post.likes}'),
                IconButton(
                  icon: Icon(Icons.thumb_down),
                  onPressed: () => ref.read(postsProvider.notifier).dislikePost(
                        post.id,
                        userId,
                      ),
                ),
                Text('${post.dislikes}'),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () => _showCommentDialog(context, ref),
                ),
                Text('${post.comments.length}'),
              ],
            ),
            for (var comment in post.comments)
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage(comment.profileImagePath)),
                title: Text(comment.username),
                subtitle: Text(comment.content),
              ),
          ],
        ),
      ),
    );
  }

  void _showCommentDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        final commentController = TextEditingController();
        return AlertDialog(
          title: Text('Add Comment'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: 'Enter your comment'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  final username =
                      jsonDecode(prefs.getString('profile')!)['student_name'];
                  final profileImagePath = prefs.getString('pfpPath') ??
                      'assets/images/pfp/default.jpg';
                  final comment = Comment(
                      id: '',
                      username: username,
                      profileImagePath: profileImagePath,
                      content: commentController.text,
                      timestamp: DateTime.now());
                  ref.read(postsProvider.notifier).addComment(post.id, comment);
                  Navigator.pop(context);
                });
              },
              child: Text('Comment'),
            ),
          ],
        );
      },
    );
  }
}
