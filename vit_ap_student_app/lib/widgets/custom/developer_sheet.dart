import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperBottomSheet extends StatefulWidget {
  const DeveloperBottomSheet({super.key});

  @override
  State<DeveloperBottomSheet> createState() => _DeveloperBottomSheetState();
}

class _DeveloperBottomSheetState extends State<DeveloperBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 125,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/footer/footer.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Crafted with ❤️ by',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 144,
                        height: 44,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.2),
                            borderRadius: BorderRadius.circular(9)),
                        child: Center(
                          child: Text(
                            'Udhay Adithya',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      onTap: () {
                        _myBottomSheet();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _myBottomSheet() {
    int hitCount = 0;
    return showModalBottomSheet(
      showDragHandle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          width: 500,
          height: 425,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/images/lottie/smile.json",
                      frameRate: const FrameRate(60),
                      width: 45,
                      repeat: true,
                    ),
                    Text(
                      "Developer",
                      style: TextStyle(
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey.withOpacity(0.25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              hitCount += 1;
                              print(hitCount);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 140,
                                ),
                                Positioned(
                                  bottom: 10,
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundImage:
                                        AssetImage('assets/images/pfp/dev.png'),
                                  ),
                                ),
                                Positioned(
                                  top: -15,
                                  right: 0,
                                  child: Lottie.asset(
                                    "assets/images/lottie/wave.json",
                                    frameRate: const FrameRate(60),
                                    width: 80,
                                    repeat: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Udhay Adithya",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          "Self-Taught Developer",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 1,
                              width: 15,
                              color: Theme.of(context).colorScheme.tertiary,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton.icon(
                                onPressed: () async {
                                  Uri _url = Uri.parse(
                                      "https://www.linkedin.com/in/udhay-adithya/");
                                  if (!await launchUrl(_url)) {
                                    throw Exception('Could not launch $_url');
                                  }
                                },
                                icon: Image.asset(
                                  "assets/images/icons/linkedin.png",
                                  height: 28,
                                ),
                                label: Text(
                                  'LinkedIn',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton.icon(
                                onPressed: () async {
                                  Uri _url = Uri.parse(
                                      "https://github.com/Udhay-Adithya");
                                  if (!await launchUrl(_url)) {
                                    throw Exception('Could not launch $_url');
                                  }
                                },
                                icon: Image.asset(
                                  "assets/images/icons/github.png",
                                  height: 28,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                label: Text(
                                  'Github',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
