import 'package:flutter/material.dart';

import 'my_scard.dart';

class SwipeableCards extends StatefulWidget {
  const SwipeableCards({super.key});

  @override
  State<SwipeableCards> createState() => _SwipeableCardsState();
}

class _SwipeableCardsState extends State<SwipeableCards> {
  List<int> cardOrder = [0, 1, 2];

  List<LinearGradient> color = [
    const LinearGradient(
      colors: [Color(0xffFF512F), Color(0xffDD2476)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color(0xff1488CC),
        Color(0xff2B32B2),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xffad5389), Color(0xff3c1053)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  void changeCardOrder(int sCard, int index) {
    setState(() {
      LinearGradient materialAccentColor = color[index];
      cardOrder.remove(sCard);
      color.remove(color[index]);
      color.insert(0, materialAccentColor);
      cardOrder.insert(0, sCard);
    });
  }

  @override
  void initState() {
    super.initState();
    cardOrder = cardOrder.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Stack(
          children: [
            for (int i = 0; i < cardOrder.length; i++)
              SCard(
                color: color[i],
                index: i,
                key: ValueKey(cardOrder[i]),
                value: cardOrder[i],
                onDragged: () => changeCardOrder(cardOrder[i], i),
              )
          ],
        ),
      ),
    );
  }
}
