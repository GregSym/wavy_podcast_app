import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:provider/provider.dart';

class PodcastPlayButton extends StatelessWidget {
  final double iconSize;
  const PodcastPlayButton({Key? key, this.iconSize = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastPlayerController>(
      builder: (context, _podcastController, _) => IconButton(
        onPressed: () => _podcastController.toggle(),
        icon: _podcastController.isPlaying
            ? Icon(Icons.pause_circle)
            : Icon(Icons.play_circle),
        iconSize: iconSize,
      ),
    );
  }
}
