import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vit_ap_student_app/models/widgets/home/outing_bottom_sheet.dart';
import 'wifi_bottom_sheet.dart';
import 'main_bottom_sheet.dart';

class MyBottomSheetContent extends StatefulWidget {
  const MyBottomSheetContent({super.key});

  @override
  State<MyBottomSheetContent> createState() => MyBottomSheetContentState();
}

class MyBottomSheetContentState extends State<MyBottomSheetContent> {
  final CarouselController _carouselController = CarouselController();
  int _currentPage = 1;

  List<Widget> _bottomSheets = [
    OutingBottomSheet(),
    MainBottomSheet(),
    WifiBottomSheet(),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: _bottomSheets.length,
      itemBuilder: (context, index, realIndex) {
        return _bottomSheets[index];
      },
      options: CarouselOptions(
        height: 350,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        initialPage: _currentPage,
        onPageChanged: (index, reason) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }

  void navigateToPage(int pageIndex) {
    _carouselController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
