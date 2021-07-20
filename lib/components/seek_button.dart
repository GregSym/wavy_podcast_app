import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:provider/provider.dart';

/// Seeking button that can take a bool to indicate rewind or fast forward
class PodcastSeekButton extends StatelessWidget {
  final bool rewind;
  const PodcastSeekButton({Key? key, this.rewind = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastPlayerController>(
        builder: (context, _podcastController, _) => IconButton(
              onPressed: () => _podcastController.skip(rewindSkip: rewind),
              icon: !rewind
                  ? Icon(Icons.fast_forward_rounded)
                  : Icon(Icons.fast_rewind_rounded),
            ));
  }
}
