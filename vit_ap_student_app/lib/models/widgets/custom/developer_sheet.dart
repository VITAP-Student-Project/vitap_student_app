import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/footer/footer.png', // Path to your background image
                fit: BoxFit.cover,
              ),
            ),
            // Footer Content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Designed and Developed with ❤️ by',
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
                        width: 150,
                        height: 50,
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
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  "Developer",
                  style: TextStyle(
                    fontFamily: 'SourceCodePro',
                    letterSpacing: 0,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).colorScheme.secondary),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage:
                                AssetImage('assets/images/pfp/default.jpg'),
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
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).colorScheme.background),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Eat() ',
                                    style: TextStyle(
                                      fontFamily: 'SourceCodePro',
                                      color: Colors.lightGreenAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sleep() ',
                                    style: TextStyle(
                                      fontFamily: 'SourceCodePro',
                                      color: Colors.lightBlueAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Play() ',
                                    style: TextStyle(
                                      fontFamily: 'SourceCodePro',
                                      color: Colors.orangeAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Code() ',
                                    style: TextStyle(
                                      fontFamily: 'SourceCodePro',
                                      color: Colors.yellowAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Repeat()',
                                    style: TextStyle(
                                      fontFamily: 'SourceCodePro',
                                      color: Colors.pinkAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                            GestureDetector(
                              child: Container(
                                width: 125,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 1.2),
                                    borderRadius: BorderRadius.circular(9)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.instagram,
                                        color: Colors.pinkAccent.shade400,
                                      ),
                                      Text(
                                        'Instagram',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                Uri _url = Uri.parse(
                                    "https://www.instagram.com/udhay_adithya");
                                if (!await launchUrl(_url)) {
                                  throw Exception('Could not launch $_url');
                                }
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                width: 125,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 1.2),
                                    borderRadius: BorderRadius.circular(9)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.github,
                                      ),
                                      Text(
                                        'Github',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                Uri _url = Uri.parse(
                                    "https://github.com/Udhay-Adithya");
                                if (!await launchUrl(_url)) {
                                  throw Exception('Could not launch $_url');
                                }
                              },
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
