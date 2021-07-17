import 'package:better_player/better_player.dart';

class PodcastPlayerController {
  BetterPlayerController _podcastController =
      BetterPlayerController(BetterPlayerConfiguration());

  /// Probably going to improve this at some point so that it supplies dynamic
  /// controllers for different platforms
  BetterPlayerController get podcastController => _podcastController;

  bool get isInitialized {
    if (_podcastController.isVideoInitialized() == null) {
      return false;
    }
    return _podcastController.isVideoInitialized()!;
  }

  double get position =>
      _podcastController.videoPlayerController!.value.position.inMilliseconds
          .toDouble(); // TODO: add a null check here

  double get duration =>
      _podcastController.videoPlayerController!.value.duration!.inMilliseconds
          .toDouble(); // TODO: add a null check here

  get events => null;

  // METHODS

  play() => null;

  pause() => null;

  Future<void> seekTo(double position) =>
      _podcastController.seekTo(Duration(milliseconds: (position).toInt()));

  skipForward() => null;

  skipBackward() => null;
}
