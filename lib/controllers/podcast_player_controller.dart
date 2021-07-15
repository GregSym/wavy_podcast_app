import 'package:better_player/better_player.dart';

class PodcastPlayerController {
  BetterPlayerController _podcastController =
      BetterPlayerController(BetterPlayerConfiguration());

  BetterPlayerController get podcastController => _podcastController;
}
