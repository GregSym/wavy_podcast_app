import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/functions/transitions.dart';

class UserDialogue extends StatelessWidget {
  const UserDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Signed out'),
        TextButton.icon(
            onPressed: null,
            icon: Icon(Icons.open_in_browser),
            label: Text('Sign in')),
        TextButton.icon(
            onPressed: null,
            icon: Icon(Icons.add),
            label: Text('Create Account')),
        Divider(),
        TextButton.icon(
            onPressed: () => Transitions.transitionToSettings(context),
            icon: Icon(Icons.settings),
            label: Text('Settings')),
      ],
    );
  }
}
