import 'package:flutter/cupertino.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:provider/provider.dart';

/// shows both position and duration by default
/// - setting this to false returns
/// position by default
/// - set justDuration to true to get just the duration - overrides positionAndDuration
/// flag
class PodcastTimestamp extends StatelessWidget {
  final bool positionAndDuration;
  final bool justDuration;
  const PodcastTimestamp({
    Key? key,
    this.positionAndDuration = true,
    this.justDuration = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PodcastPlayerController>(
      builder: (context, _podcastController, _) => justDuration
          ? Text(
              "${_podcastController.duration}",
            )
          : positionAndDuration
              ? Text(
                  "${_podcastController.position} / ${_podcastController.duration}",
                )
              : Text(
                  "${_podcastController.position}",
                ),
    );
  }
}
