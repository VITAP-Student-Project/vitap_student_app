import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final CarouselSliderController controller;

  const CarouselIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isSelected = currentIndex == index;
        return GestureDetector(
          onTap: () => controller.animateToPage(index),
          child: AnimatedContainer(
            width: isSelected ? 30 : 15,
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: isSelected ? 6 : 3),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(9),
            ),
            duration: const Duration(milliseconds: 300),
          ),
        );
      }),
    );
  }
}
