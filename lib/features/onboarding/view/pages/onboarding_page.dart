import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/utils/theme_switch_button.dart';
import 'package:vit_ap_student_app/features/auth/view/pages/login_page.dart';
import 'package:vit_ap_student_app/features/onboarding/view/widgets/onboarding_slide.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends ConsumerState<OnboardingPage> {
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
          MaterialPageRoute(
            builder: (builder) => LoginPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [ThemeSwitchButton()],
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
                items: [
                  OnboardingSlide(
                    imagePath: "assets/images/onboarding/adventure.svg",
                    title: "Welcome",
                    description:
                        "Manage your academic info and track you performance effortlessly—all with one simple login.",
                  ),
                  OnboardingSlide(
                    imagePath: "assets/images/onboarding/education.svg",
                    title: "Effortless Academic Access",
                    description:
                        "Access your timetable, grades, attendance, and payments all in one place. Stay organized and informed effortlessly.",
                  ),
                  OnboardingSlide(
                    imagePath: "assets/images/onboarding/notifications.svg",
                    title: "Smart Notifications & Utilities",
                    description:
                        "Stay informed with real-time class alerts, exam notifications, and important university announcements. Access live weather updates and campus events—all in one place.",
                  ),
                  _WelcomePage(),
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
                          : Theme.of(context).colorScheme.primaryFixed,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              }),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: _onNextPressed,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: Size(180, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Text(currentPageIndex < 3 ? 'Next' : 'Get Started',
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

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
                'assets/images/onboarding/mobile_feed.svg',
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
                left: MediaQuery.sizeOf(context).width - 275,
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
