import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color iconBackgroundColor;

  const IconTextButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed,
      required this.iconBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black12,
                  ],
                  stops: [0.4, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                blendMode: BlendMode.darken,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      icon,
                      size: 26,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
