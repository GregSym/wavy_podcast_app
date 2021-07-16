import 'package:better_player/better_player.dart';

class PodcastPlayerController {
  BetterPlayerController _podcastController =
      BetterPlayerController(BetterPlayerConfiguration());

  /// Probably going to improve this at some point so that it supplies dynamic
  /// controllers for different platforms
  BetterPlayerController get podcastController => _podcastController;

  get events => null;

  // METHODS

  play() => null;

  pause() => null;

  skipForward() => null;

  skipBackward() => null;
}
