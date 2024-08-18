import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<void> showLoadingDialog(
    BuildContext context, String initialSubtitle) async {
  Navigator.of(context).push(
    PageRouteBuilder(
      barrierDismissible: true,
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return LoadingDialog(initialSubtitle: initialSubtitle);
      },
    ),
  );
}

class LoadingDialog extends StatefulWidget {
  final String initialSubtitle;

  LoadingDialog({required this.initialSubtitle});

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  late String subtitle;
  late Timer _timer;
  final List<String> _loadingMessages = [
    'Just grabbing a ☕️\nand taking a deep breath...',
    'Getting things in order 📋\nmaking sure everything is perfect...',
    'Chasing down bugs 🐞\nthey can be sneaky little critters...',
    'Summoning the loading fairies ✨ to\nsprinkle some magic...',
    'Preparing the magic 🪄\nBrewing up something special...',
    'Finding the loading spell 🔮\njust a few moments, promise!',
  ];
  int _currentMessageIndex = 0;

  @override
  void initState() {
    super.initState();
    subtitle = widget.initialSubtitle;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        _currentMessageIndex =
            (_currentMessageIndex + 1) % _loadingMessages.length;
        subtitle = _loadingMessages[_currentMessageIndex];
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.easeInOut,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 300,
          height: 230,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 75,
                child: Lottie.asset(
                  "assets/images/lottie/among_us.json",
                  height: 200,
                  frameRate: FrameRate(60),
                ),
              ),
              Positioned(
                bottom: 75,
                child: Text(
                  "Hold Tight",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Positioned(
                bottom: 30,
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
