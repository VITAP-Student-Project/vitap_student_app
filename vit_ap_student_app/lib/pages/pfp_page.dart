import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/pages/features/login_page.dart';

final selectedImageProvider = StateProvider<int?>((ref) => null);

class MyProfilePicScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedImageProvider);

    final List<String> imagePaths = [
      'assets/images/pfp/default.jpg',
      'assets/images/pfp/boy_1.jpg',
      'assets/images/pfp/boy_2.jpg',
      'assets/images/pfp/boy_3.jpg',
      'assets/images/pfp/girl_1.jpg',
      'assets/images/pfp/boy_4.jpg',
      'assets/images/pfp/girl_2.jpg',
      'assets/images/pfp/boy_5.jpg',
      'assets/images/pfp/girl_3.jpg',
      'assets/images/pfp/girl_4.jpg',
      'assets/images/pfp/girl_5.jpg',
      'assets/images/pfp/boy_6.jpg',
      'assets/images/pfp/boy_7.jpg',
      'assets/images/pfp/boy_8.jpg',
    ];

    int numRows = (imagePaths.length / 4).ceil();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Pick an Avatar",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Choose a profile picture that best represents you. You can change it anytime from your profile settings.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.blueGrey[50],
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: selectedIndex != null
                      ? AssetImage(imagePaths[selectedIndex!])
                      : AssetImage('assets/images/pfp/default.jpg'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: List.generate(numRows, (rowIndex) {
                  int startIndex = rowIndex * 4;
                  int endIndex = (rowIndex + 1) * 4;
                  if (endIndex > imagePaths.length) {
                    endIndex = imagePaths.length;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(endIndex - startIndex, (index) {
                      int imageIndex = startIndex + index;
                      return GestureDetector(
                        onTap: () {
                          ref.read(selectedImageProvider.notifier).state =
                              imageIndex;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: selectedIndex == imageIndex
                                ? Colors.greenAccent
                                : Colors.transparent,
                            child: CircleAvatar(
                              radius: 34,
                              backgroundImage:
                                  AssetImage(imagePaths[imageIndex]),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () async {
                  if (selectedIndex != null) {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('pfpPath', imagePaths[selectedIndex]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else {
                    // Show a message to select an image
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select an avatar.')),
                    );
                  }
                },
                height: 60,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text('Confirm'),
                color: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
