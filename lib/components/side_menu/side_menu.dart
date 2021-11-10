import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/constants/std_sizes.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:flutter_podcast_app/functions/transitions.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Reactivity.width(context) < StandardSizes.phoneWidth)
      return Container();
    else if (Reactivity.width(context) < StandardSizes.minimizedWidth)
      return Container(
        width: Reactivity.width(context) / 10,
        child: Column(
          children: [
            IconButton(
                onPressed: null, icon: Icon(Icons.compass_calibration_rounded)),
            IconButton(onPressed: null, icon: Icon(Icons.check)),
            IconButton(onPressed: null, icon: Icon(Icons.wifi)),
            Divider(),
            IconButton(onPressed: null, icon: Icon(Icons.settings)),
          ],
        ),
      );
    return Container(
      width: 300,
      child: Column(
        children: [
          TextButton.icon(
            onPressed: null,
            icon: Icon(Icons.compass_calibration_rounded),
            label: Text("Explore"),
          ),
          TextButton.icon(
            onPressed: null,
            icon: Icon(Icons.check),
            label: Text("Subscriptions"),
          ),
          TextButton.icon(
            onPressed: null,
            icon: Icon(Icons.wifi),
            label: Text("Add by RSS Feed"),
          ),
          Divider(),
          TextButton.icon(
            onPressed: () => Transitions.transitionToSettings(context),
            icon: Icon(Icons.settings),
            label: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
