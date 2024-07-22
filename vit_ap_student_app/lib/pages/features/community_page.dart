import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/pages/features/create_post.dart';

import '../../models/user/User.dart';
import '../../utils/provider/community_provider.dart';

class CommunityPage extends ConsumerWidget {
  initState() {
    PostsNotifier().fetchPosts();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Community')),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostTile(post: post);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostDialog(context),
        child: Icon(Icons.add),
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

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(post.profileImagePath)),
      title: Text(
        post.username,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      subtitle: Text(post.content),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () => _likePost(context),
          ),
          IconButton(
            icon: Icon(Icons.thumb_down),
            onPressed: () => _dislikePost(context),
          ),
          IconButton(
            icon: Icon(Icons.comment),
            onPressed: () => _commentOnPost(context),
          ),
        ],
      ),
    );
  }

  void _likePost(BuildContext context) {
    // Logic to like a post
  }

  void _dislikePost(BuildContext context) {
    // Logic to dislike a post
  }

  void _commentOnPost(BuildContext context) {
    // Logic to comment on a post
  }
}
