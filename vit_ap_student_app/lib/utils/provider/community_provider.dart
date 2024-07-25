import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user/User.dart';

final postsProvider = StateNotifierProvider<PostsNotifier, List<Post>>((ref) {
  return PostsNotifier();
});

class PostsNotifier extends StateNotifier<List<Post>> {
  PostsNotifier() : super([]) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final snapshot = await FirebaseFirestore.instance.collection('posts').get();
    final posts = snapshot.docs
        .map((doc) => Post.fromJson(doc.data()..addAll({'id': doc.id})))
        .toList();
    state = posts;
  }

  Future<void> addPost(Post post) async {
    final docRef =
        await FirebaseFirestore.instance.collection('posts').add(post.toJson());
    state = [...state, post.copyWith(id: docRef.id)];
  }

  Future<void> deletePost(String postId) async {
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
    state = state.where((post) => post.id != postId).toList();
  }

  Future<void> updatePost(Post post) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(post.id)
        .update(post.toJson());
    state = state.map((p) => p.id == post.id ? post : p).toList();
  }

  Future<void> likePost(String postId, String userId) async {
    final post = state.firstWhere((post) => post.id == postId);
    if (!post.likedBy.contains(userId)) {
      final updatedPost = post.copyWith(
        likes: post.likes + 1,
        likedBy: [...post.likedBy, userId],
        dislikedBy: post.dislikedBy.where((id) => id != userId).toList(),
        dislikes: post.dislikedBy.contains(userId)
            ? post.dislikes - 1
            : post.dislikes,
      );
      await updatePost(updatedPost);
    }
  }

  Future<void> dislikePost(String postId, String userId) async {
    final post = state.firstWhere((post) => post.id == postId);
    if (!post.dislikedBy.contains(userId)) {
      final updatedPost = post.copyWith(
        dislikes: post.dislikes + 1,
        dislikedBy: [...post.dislikedBy, userId],
        likedBy: post.likedBy.where((id) => id != userId).toList(),
        likes: post.likedBy.contains(userId) ? post.likes - 1 : post.likes,
      );
      await updatePost(updatedPost);
    }
  }

  Future<void> addComment(String postId, Comment comment) async {
    final post = state.firstWhere((post) => post.id == postId);
    final updatedPost = post.copyWith(comments: [...post.comments, comment]);
    await updatePost(updatedPost);
  }
}
