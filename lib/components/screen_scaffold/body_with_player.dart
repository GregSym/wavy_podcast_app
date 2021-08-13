import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_player.dart';

class BodyWithPlayer extends StatelessWidget {
  final Widget child;
  const BodyWithPlayer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: child,
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}
