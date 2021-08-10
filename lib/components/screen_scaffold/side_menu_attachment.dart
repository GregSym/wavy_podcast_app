import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/side_menu/side_menu.dart';

class SideMenuAttachment extends StatelessWidget {
  final Widget child;
  const SideMenuAttachment({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SideMenu(),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
