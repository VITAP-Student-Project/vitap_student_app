import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/provider/theme_provider.dart';

final selectedImageProvider = StateProvider<int?>((ref) => null);

class MyProfilePicScreen extends ConsumerWidget {
  final String instructionText;
  final Widget nextPage;

  const MyProfilePicScreen({
    super.key,
    required this.instructionText,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedImageProvider);

    final List<String> imagePaths = [
      'assets/images/pfp/default.png',
      'assets/images/pfp/astronaut.png',
      'assets/images/pfp/bear.png',
      'assets/images/pfp/cat.png',
      'assets/images/pfp/chicken.png',
      'assets/images/pfp/dog.png',
      'assets/images/pfp/duck.png',
      'assets/images/pfp/man.png',
      'assets/images/pfp/man_1.png',
      'assets/images/pfp/masked.png',
      'assets/images/pfp/ninja.png',
      'assets/images/pfp/panda.png',
      'assets/images/pfp/woman.png',
      'assets/images/pfp/woman_1.png',
    ];

    int numRows = (imagePaths.length / 4).ceil();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Pick an Avatar",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: Icon(
              ref.watch(themeModeProvider) == AppThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              final currentTheme = ref.read(themeModeProvider);
              final newTheme = currentTheme == AppThemeMode.dark
                  ? AppThemeMode.light
                  : AppThemeMode.dark;
              ref.read(themeModeProvider.notifier).setThemeMode(newTheme);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                instructionText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.blueGrey[50],
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: selectedIndex != null
                      ? AssetImage(imagePaths[selectedIndex!])
                      : const AssetImage('assets/images/pfp/default.png'),
                ),
              ),
              const SizedBox(
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
                          padding: const EdgeInsets.all(4.0),
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
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                elevation: 0,
                onPressed: () async {
                  if (selectedIndex != null) {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('pfpPath', imagePaths[selectedIndex]);
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.fade,
                        child: nextPage,
                      ),
                    );
                  } else {
                    // Show a message to select an image
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select an avatar.')),
                    );
                  }
                },
                height: 60,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.secondary,
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
