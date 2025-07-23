import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/utils/theme_switch_button.dart';

class ProfilePicturePage extends ConsumerWidget {
  final String instructionText;
  final Widget? nextPage;

  const ProfilePicturePage({
    super.key,
    required this.instructionText,
    this.nextPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPrefs = ref.watch(userPreferencesNotifierProvider);
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
        title: Text(
          "Pick an Avatar",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        actions: [ThemeSwitchButton()],
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
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.blueGrey[50],
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(userPrefs.pfpPath),
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
                          ref
                              .read(userPreferencesNotifierProvider.notifier)
                              .updatePreferences(
                                userPrefs.copyWith(
                                  pfpPath: imagePaths[imageIndex],
                                ),
                              );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor:
                                userPrefs.pfpPath == imagePaths[imageIndex]
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  minimumSize: Size(MediaQuery.sizeOf(context).width / 2, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                onPressed: () {
                  if (nextPage == null) {
                    Navigator.pop(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => nextPage!,
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
