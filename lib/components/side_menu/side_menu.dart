import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Explore"),
        Text("Subscriptions"),
        Text("Add by RSS Feed"),
        Divider(),
        Text("Settings"),
      ],
    );
  }
}
