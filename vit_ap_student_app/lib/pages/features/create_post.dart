import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user/User.dart';
import '../../utils/provider/community_provider.dart';

class CreatePostDialog extends ConsumerStatefulWidget {
  @override
  _CreatePostDialogState createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends ConsumerState<CreatePostDialog> {
  final _contentController = TextEditingController();
  String _postType = 'text'; // Default post type
  File? _mediaFile;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create a New Post'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: 'Enter post content'),
              maxLines: 4,
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _postType,
              items: ['text', 'link', 'image', 'audio', 'video']
                  .map((type) => DropdownMenuItem(
                        child: Text(type),
                        value: type,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _postType = value!;
                  if (['image', 'audio', 'video'].contains(_postType)) {
                    _pickMedia();
                  }
                });
              },
            ),
            if (_mediaFile != null) ...[
              SizedBox(height: 10),
              _postType == 'image'
                  ? Image.file(_mediaFile!)
                  : Text(
                      'Selected ${_postType}: ${_mediaFile!.path.split('/').last}'),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _createPost(ref, context),
          child: Text('Post'),
        ),
      ],
    );
  }

  Future<void> _pickMedia() async {
    final picker = ImagePicker();
    XFile? pickedFile;

    switch (_postType) {
      case 'image':
        pickedFile = await picker.pickImage(source: ImageSource.gallery);
        break;
      case 'audio':
        // Implement media picking for audio
        break;
      case 'video':
        // Implement media picking for video
        break;
    }

    if (pickedFile != null) {
      setState(() {
        _mediaFile = File(pickedFile!.path);
      });
    }
  }

  void _createPost(WidgetRef ref, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString('profile');
    final username = profileJson != null
        ? jsonDecode(profileJson)['student_name']
        : 'Anonymous';
    final profileImagePath =
        prefs.getString('pfpPath') ?? 'assets/images/pfp/default.jpg';

    final post = Post(
      id: '', // Generate unique ID if necessary
      username: username,
      profileImagePath: profileImagePath,
      content: _contentController.text,
      type: _postType,
      likes: 0,
      dislikes: 0,
      comments: [],
      timestamp: DateTime.now(), // Add the timestamp
      likedBy: [], // Initialize as an empty list
      dislikedBy: [], // Initialize as an empty list
    );

    // Handle media upload here if necessary and update the post content accordingly

    ref.read(postsProvider.notifier).addPost(post);
    Navigator.pop(context);
  }
}
