import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/models/shimmers/shimmer_skeleton.dart';
import 'package:shimmer/shimmer.dart';

class WeatherWidgetShimmer extends StatelessWidget {
  const WeatherWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: const Duration(milliseconds: 3000),
        baseColor: Colors.white,
        highlightColor: Colors.black.withOpacity(0.04),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeleton(
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
        ));
  }
}
