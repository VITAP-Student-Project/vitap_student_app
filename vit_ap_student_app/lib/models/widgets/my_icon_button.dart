import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  IconTextButton(
      {required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            child: Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9), color: Colors.black87),
          ),
          Text(text),
        ],
      ),
    );
  }
}
