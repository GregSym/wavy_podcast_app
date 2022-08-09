import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/play_button.dart';
import 'package:flutter_podcast_app/components/seek_button.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:provider/provider.dart';

/// Single component for controls row
class PodcastControlsRow extends StatelessWidget {
  const PodcastControlsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastPlayerController>(
        builder: (context, podcastController, _) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                PodcastSeekButton(rewind: true), // left to right
                PodcastPlayButton(),
                PodcastSeekButton()
              ],
            ));
  }
}
