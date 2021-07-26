import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:provider/provider.dart';

class MiniPlayButton extends StatelessWidget {
  final double iconSize;
  const MiniPlayButton({Key? key, this.iconSize = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastPlayerController>(
      builder: (context, _podcastController, _) => IconButton(
        onPressed: () => _podcastController.toggle(),
        icon: _podcastController.isPlaying
            ? Icon(Icons.pause)
            : Icon(Icons.play_arrow_outlined),
        iconSize: iconSize,
      ),
    );
  }
}
