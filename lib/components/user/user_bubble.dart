import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/user/user_dialogue.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:flutter_podcast_app/functions/transitions.dart';
import 'package:flutter_podcast_app/screens/settings_screen.dart';

class UserBubble extends StatelessWidget {
  const UserBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () =>
          showDialog(context: context, builder: (context) => UserDialogue()),
      icon: Icon(Icons.circle),
      iconSize: Reactivity.userIconHeight(context),
    );
  }
}
