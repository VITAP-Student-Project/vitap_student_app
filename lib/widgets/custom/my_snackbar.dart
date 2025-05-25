import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class MySnackBar extends StatelessWidget {
  final String title;
  final String message;
  final ContentType contentType;

  const MySnackBar({
    Key? key,
    required this.title,
    required this.message,
    required this.contentType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      duration: Duration(seconds: 30),

      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: contentType,
      ),
    );
  }
}
