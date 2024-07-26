// community_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/pages/features/create_post.dart';
import '../../utils/provider/community_provider.dart';
import '../../utils/provider/post_tile.dart';
import 'sort_criteria.dart'; // Ensure this import path is correct

class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({super.key});

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  late Future<String> _userIdFuture;

  @override
  void initState() {
    super.initState();
    _userIdFuture = fetchUserRegNo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postsProvider.notifier).fetchPosts();
    });
  }

  Future<String> fetchUserRegNo() async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString('profile')!)['student_name'] ??
        ''; // Return empty string if no userId found
  }

  Future<void> _refreshPosts() async {
    await ref.read(postsProvider.notifier).fetchPosts();
  }

  // Add sorting logic
  void _sortPosts(SortCriteria criteria) {
    ref.read(postsProvider.notifier).sortPosts(criteria);
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
        actions: [
          PopupMenuButton<SortCriteria>(
            onSelected: _sortPosts,
            itemBuilder: (context) => <PopupMenuEntry<SortCriteria>>[
              const PopupMenuItem<SortCriteria>(
                value: SortCriteria.mostLiked,
                child: Text('Most Liked'),
              ),
              const PopupMenuItem<SortCriteria>(
                value: SortCriteria.mostRecent,
                child: Text('Most Recent'),
              ),
            ],
          ),
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
                  SizedBox(height: 8),
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
