import 'package:flutter/material.dart';

class MyHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/profile_image.jpg'),
          ),
          SizedBox(width: 10), // Add space between the avatar and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome,',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                'Udhay Adithya',
                style: TextStyle(
                  fontSize: 20, // Adjust the font size as needed
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
