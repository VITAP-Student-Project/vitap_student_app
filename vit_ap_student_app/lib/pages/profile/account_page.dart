import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Account"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('assets/images/profile_image.jpg'),
                  ),
                ),
                Text("Udhay Adithya J"),
                Text("23BCE7625"),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name : "),
              Text("Application Number : "),
              Text("Email ID : "),
              Text("Date of Birth : "),
              Text("Gender : "),
              Text("Blood Group : "),
            ],
          ),
        ],
      ),
    );
  }
}
