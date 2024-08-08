import 'package:flutter/material.dart';

class OutingBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Theme.of(context).colorScheme.background,
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.home_work_outlined),
              Text(
                "Outing",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.close_rounded)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Divider(
              thickness: 0.4,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              "Outing Requests Simplified",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              "No more hassle with outing requests. Submit your outing request with a single click and get approved quickly.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75.0),
            child: Divider(
              thickness: 0.2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.shopping_bag_outlined),
                label: Text('Weekend Outing'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.home_work_outlined),
                label: Text('General Outing'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
