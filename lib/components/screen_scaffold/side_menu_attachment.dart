import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/side_menu/side_menu.dart';
import 'package:flutter_podcast_app/constants/std_sizes.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';

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
            child: Reactivity.width(context) > StandardSizes.phoneWidth
                ? _WideScreenFinish(child: child)
                : child,
          ),
        ],
      ),
    );
  }
}

class _WideScreenFinish extends StatelessWidget {
  final Widget child;
  const _WideScreenFinish({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}
