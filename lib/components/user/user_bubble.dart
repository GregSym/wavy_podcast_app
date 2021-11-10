import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:flutter_podcast_app/functions/transitions.dart';

class UserBubble extends StatelessWidget {
  const UserBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Transitions.transitionToSettings(context),
      icon: Icon(Icons.circle),
      iconSize: Reactivity.expandedAppBarHeight(context) / 2,
    );
  }
}
