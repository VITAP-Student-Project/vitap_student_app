import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user/User.dart';
import '../../pages/features/sort_criteria.dart'; // Ensure this import path is correct

final postsProvider = StateNotifierProvider<PostsNotifier, List<Post>>((ref) {
  return PostsNotifier();
});

class PostsNotifier extends StateNotifier<List<Post>> {
  PostsNotifier() : super([]) {
    fetchPosts();
  }

  final CollectionReference _postsRef =
      FirebaseFirestore.instance.collection('posts');

  Future<void> fetchPosts() async {
    try {
      final snapshot = await _postsRef.get();
      final posts = await Future.wait(snapshot.docs.map((doc) async {
        final postData = doc.data() as Map<String, dynamic>;
        final commentsSnapshot =
            await doc.reference.collection('comments').get();
        final comments = commentsSnapshot.docs.map((commentDoc) {
          final commentData = commentDoc.data();
          return Comment.fromJson(commentData).copyWith(id: commentDoc.id);
        }).toList();
        return Post.fromJson(postData)
          ..id = doc.id
          ..comments = comments;
      }).toList());
      state = posts;
    } catch (e) {
      print('Error fetching posts: $e');
    }
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

  void sortPosts(SortCriteria criteria) {
    if (criteria == SortCriteria.mostLiked) {
      state = [...state]..sort((a, b) => b.likes.compareTo(a.likes));
    } else if (criteria == SortCriteria.mostRecent) {
      state = [...state]..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    }
  }

  Future<void> likePost(String postId, String userId) async {
    try {
      final postIndex = state.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = state[postIndex];
        final isAlreadyLiked = post.likedBy.contains(userId);
        final isAlreadyDisliked = post.dislikedBy.contains(userId);

        if (isAlreadyLiked) {
          // Unlike the post
          post.likedBy.remove(userId);
          post.likes -= 1;
        } else {
          // Like the post
          post.likedBy.add(userId);
          post.likes += 1;
          // Ensure no double counting of dislikes
          if (isAlreadyDisliked) {
            post.dislikedBy.remove(userId);
            post.dislikes -= 1;
          }
        }
        await _postsRef.doc(postId).update(post.toJson());
        state = [...state];
      }
    } catch (e) {
      print('Error liking post: $e');
    }
  }

  Future<void> dislikePost(String postId, String userId) async {
    try {
      final postIndex = state.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = state[postIndex];
        final isAlreadyDisliked = post.dislikedBy.contains(userId);
        final isAlreadyLiked = post.likedBy.contains(userId);

        if (isAlreadyDisliked) {
          // Remove dislike from the post
          post.dislikedBy.remove(userId);
          post.dislikes -= 1;
        } else {
          // Dislike the post
          post.dislikedBy.add(userId);
          post.dislikes += 1;
          // Ensure no double counting of likes
          if (isAlreadyLiked) {
            post.likedBy.remove(userId);
            post.likes -= 1;
          }
        }
        await _postsRef.doc(postId).update(post.toJson());
        state = [...state];
      }
    } catch (e) {
      print('Error disliking post: $e');
    }
  }

  Future<void> addComment(String postId, Comment comment) async {
    try {
      final postIndex = state.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        // Add the comment to the subcollection
        final commentDocRef = await _postsRef
            .doc(postId)
            .collection('comments')
            .add(comment.toJson());
        final newComment = comment.copyWith(id: commentDocRef.id);

        // Update the post with the new comment
        final post = state[postIndex];
        final updatedPost =
            post.copyWith(comments: [...post.comments, newComment]);
        await _postsRef.doc(postId).update(updatedPost.toJson());

        // Update the local state with the new comment
        state = [
          for (final p in state)
            if (p.id == postId) updatedPost else p
        ];
      }
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  Future<void> likeComment(
      String postId, String commentId, String userId) async {
    try {
      final postIndex = state.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = state[postIndex];
        final commentIndex =
            post.comments.indexWhere((comment) => comment.id == commentId);
        if (commentIndex != -1) {
          final comment = post.comments[commentIndex];
          if (!comment.likedBy.contains(userId)) {
            comment.likedBy.add(userId);
            comment.likes += 1;
            await _postsRef
                .doc(postId)
                .collection('comments')
                .doc(commentId)
                .update(comment.toJson());
            state = [...state];
          }
        }
      }
    } catch (e) {
      print('Error liking comment: $e');
    }
  }
}
