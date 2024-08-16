import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

class HelpTile extends StatefulWidget {
  const HelpTile({super.key});

  @override
  State<HelpTile> createState() => _HelpTileState();
}

class _HelpTileState extends State<HelpTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(9.0)),
        child: GestureDetector(
          onTap: () {
            Wiredash.of(context).show(inheritMaterialTheme: true);
          },
          child: ListTile(
            leading: Icon(
              Icons.help_outline_rounded,
              size: 56,
            ),
            title: Text(
              "Having trouble ?",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            subtitle: Text(
              "Report now to fix them ASAP!",
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
