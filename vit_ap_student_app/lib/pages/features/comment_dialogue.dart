import 'package:flutter/material.dart';

import '../../models/user/User.dart';

class CommentDialog extends StatefulWidget {
  final String postId;
  final Function(Comment) onCommentAdded;

  CommentDialog({required this.postId, required this.onCommentAdded});

  @override
  _CommentDialogState createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  final _contentController = TextEditingController();
  String _username = 'Anonymous'; // Replace with actual username

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a Comment'),
      content: TextField(
        controller: _contentController,
        decoration: InputDecoration(hintText: 'Enter your comment'),
        maxLines: 4,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final comment = Comment(
                id: '', // Generate unique ID if necessary
                username: _username,
                profileImagePath:
                    'assets/images/pfp/default.jpg', // Default or fetch profile image
                content: _contentController.text,
                timestamp: DateTime.now());
            widget.onCommentAdded(comment);
            Navigator.pop(context);
          },
          child: Text('Comment'),
        ),
      ],
    );
  }
}
