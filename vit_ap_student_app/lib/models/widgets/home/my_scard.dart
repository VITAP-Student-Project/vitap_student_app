import 'package:flutter/material.dart';

class SCard extends StatefulWidget {
  final int index;
  final int value;
  final Function onDragged;
  final LinearGradient color;
  const SCard(
      {super.key,
      required this.index,
      required this.onDragged,
      required this.value,
      required this.color});

  @override
  State<SCard> createState() => _SCardState();
}

class _SCardState extends State<SCard> with TickerProviderStateMixin {
  Offset _position = const Offset(0, 0);
  double height = 200;
  double width = 300;

  Curve _myCurve = Curves.linear;
  Duration _duration = const Duration(milliseconds: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: ((MediaQuery.of(context).size.width / 2) - (width / 2)) +
          _position.dx,
      top: ((MediaQuery.of(context).size.height / 2) -
              (height / 2) +
              (widget.index * 20)) +
          _position.dy,

      // (_position.dy - (widget.index * 15)),
      duration: _duration,
      curve: _myCurve,
      child: GestureDetector(
        onPanUpdate: (details) {
          if (widget.index == 2) {
            _myCurve = Curves.linear;
            _duration = const Duration(milliseconds: 0);
            if (width >= 100 || height >= 100) {
              width -= 4;
              height -= 1;
            }

            _position += details.delta;
            setState(() {});
          }
        },
        onPanEnd: (details) {
          if (widget.index == 2) {
            _myCurve = Curves.easeIn;
            _duration = const Duration(milliseconds: 300);
            setState(() {
              if (_position.dx <= -(width / 2) || _position.dx >= (width / 2)) {
                // If so, move the card to the back (0th index)
                widget.onDragged();

                _position = Offset.zero;
              } else {
                _position = Offset.zero;
              }
              width = 300;
              height = 200;
            });
          }
        },
        child: AnimatedContainer(
          width: width,
          height: height,
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
                gradient: widget.color,
                borderRadius: BorderRadius.circular(20)),
            child: Center(child: Text("Item ${widget.value}")),
          ),
        ),
      ),
    );
  }

  void _animateCardBack() {
    // _animationController.forward();
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }
}