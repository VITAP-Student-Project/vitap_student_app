import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double height;
  final double width;

  const Skeleton({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(9),
      ),
    );
  }
}
