import 'package:better_player/better_player.dart';

/// Composition class for getting media player into a semi-multi-platform state
/// - this is a bad way to do this, but it's the easiest way to manage it
/// - - So maybe it's not the absolute worst?
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

  bool get isPlaying => _podcastController.isPlaying() == null
      ? false
      : _podcastController.isPlaying()!;

  double get position =>
      _podcastController.videoPlayerController!.value.position.inMilliseconds
          .toDouble(); // TODO: add a null check here

  double get duration =>
      _podcastController.videoPlayerController!.value.duration!.inMilliseconds
          .toDouble(); // TODO: add a null check here

  get events => null;

  // METHODS

  togglePlay() => (_podcastController.isPlaying()!)
      ? _podcastController.pause()
      : _podcastController.play(); // TODO: add a null check here

  play() => null;

  pause() => null;

  Future<void> seekTo(double position) =>
      _podcastController.seekTo(Duration(milliseconds: (position).toInt()));

  skipForward() => null;

  skipBackward() => null;
}
