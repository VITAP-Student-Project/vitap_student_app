import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/pages/features/create_post.dart';
import '../../utils/provider/community_provider.dart';
import 'post_tile.dart';
import 'sort_criteria.dart';

class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({super.key});

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  late Future<String> _userIdFuture;
  bool _isLoadingMore = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _userIdFuture = fetchUserRegNo();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postsProvider.notifier).fetchPosts();
    });
  }

  Future<String> fetchUserRegNo() async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString('profile')!)['student_name'] ?? '';
  }

  Future<void> _refreshPosts() async {
    await ref.read(postsProvider.notifier).fetchPosts();
  }

  void _sortPosts(SortCriteria criteria) {
    ref.read(postsProvider.notifier).sortPosts(criteria);
  }

  void _fetchMorePosts() async {
    if (_isLoadingMore) return;
    setState(() {
      _isLoadingMore = true;
    });
    await ref.read(postsProvider.notifier).fetchMorePosts();
    setState(() {
      _isLoadingMore = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchMorePosts();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);

    // Filter posts based on the search query
    final filteredPosts = posts.where((post) {
      final postTitle = post.content.toLowerCase();
      final postContent = post.content.toLowerCase();
      final searchQuery = _searchQuery.toLowerCase();
      return postTitle.contains(searchQuery) ||
          postContent.contains(searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
          PopupMenuButton<SortCriteria>(
            icon: Icon(Icons.sort_rounded),
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
            icon: const Icon(Icons.add),
            onPressed: () => _showCreatePostDialog(context),
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: _userIdFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final userId = snapshot.data!;
            if (filteredPosts.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/images/lottie/empty.json",
                    frameRate: const FrameRate(60),
                    width: 380,
                  ),
                  const SizedBox(height: 8),
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
                  controller: _scrollController,
                  itemCount: filteredPosts.length + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isLoadingMore && index == filteredPosts.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final post = filteredPosts[index];
                    return PostTile(
                      post: post,
                      userId: userId,
                    );
                  }),
            );
          } else {
            return const Center(child: Text('No user ID found'));
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

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Search Posts',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(hintText: 'Enter search query'),
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _searchQuery = _searchController.text;
              });
              Navigator.of(context).pop();
            },
            child: Text(
              'Search',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
