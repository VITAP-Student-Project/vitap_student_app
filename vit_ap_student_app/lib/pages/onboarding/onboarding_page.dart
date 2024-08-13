import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vit_ap_student_app/pages/features/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/provider/theme_provider.dart';
import 'pfp_page.dart';

class GettingStartedPage extends ConsumerStatefulWidget {
  const GettingStartedPage({super.key});

  @override
  GettingStartedPageState createState() => GettingStartedPageState();
}

class GettingStartedPageState extends ConsumerState<GettingStartedPage> {
  int currentPageIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  void _onNextPressed() {
    if (currentPageIndex < 3) {
      _carouselController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    } else {
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          type: PageTransitionType.fade,
          child: const MyProfilePicScreen(
            instructionText:
                "Choose a profile picture that best represents you. You can change it anytime from your profile settings.",
            nextPage: LoginPage(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.75,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPageIndex = index;
                    });
                  },
                ),
                items: const [
                  _PageOne(),
                  _PageTwo(),
                  _PageThree(),
                  _PageFour(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                bool isSelected = currentPageIndex == index;
                return GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(index);
                  },
                  child: AnimatedContainer(
                    width: isSelected ? 20 : 10,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              }),
            ),
            const SizedBox(height: 60),
            MaterialButton(
              onPressed: _onNextPressed,
              elevation: 8,
              height: 60,
              minWidth: 180,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              color: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.secondary,
              child: Text(currentPageIndex < 3 ? 'Next' : 'Get Started'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _PageOne extends StatelessWidget {
  const _PageOne();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 75.0),
          child: Center(
            child: SizedBox(
              width: 450.0,
              child: SvgPicture.asset(
                'assets/images/onboarding/adventure.svg',
                width: MediaQuery.sizeOf(context).width - 150,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Text(
          "Welcome",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Manage your academic info and connect\nwith your campus community\neffortlessly—all with one\nsimple login.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }
}

class _PageTwo extends StatelessWidget {
  const _PageTwo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 75.0),
          child: Center(
            child: SizedBox(
              width: 450.0,
              child: SvgPicture.asset(
                'assets/images/onboarding/education.svg',
                width: MediaQuery.sizeOf(context).width - 150,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Text(
          "Effortless Academic Access",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Access your timetable, grades, attendance, and payments all in one place. Stay organized and informed effortlessly.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ],
    );
  }
}

class _PageThree extends StatelessWidget {
  const _PageThree();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 75.0),
          child: Center(
            child: SizedBox(
              width: 450.0,
              child: SvgPicture.asset(
                'assets/images/onboarding/opinion.svg',
                width: MediaQuery.sizeOf(context).width - 150,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Text(
          "Engage and Connect",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Connect with fellow students, engage in discussions, and stay updated on campus events. Share your thoughts and be part of a vibrant community.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ],
    );
  }
}

class _PageFour extends StatelessWidget {
  const _PageFour();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 75.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: SvgPicture.asset(
                'assets/images/onboarding/feed.svg',
                width: MediaQuery.sizeOf(context).width - 150,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.sizeOf(context).width - 290,
                child: Text(
                  "All-in-One",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: MediaQuery.sizeOf(context).width - 350,
                child: Text(
                  "Academic",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Positioned(
                top: 75,
                left: MediaQuery.sizeOf(context).width - 250,
                child: Text(
                  "Awesomeness!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
