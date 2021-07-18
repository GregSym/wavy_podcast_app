import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';

/// Composition class for getting media player into a semi-multi-platform state
/// - this is a bad way to do this, but it's the easiest way to manage it
/// - - So maybe it's not the absolute worst?
class PodcastPlayerController with ChangeNotifier {
  BetterPlayerController _podcastController =
      BetterPlayerController(BetterPlayerConfiguration());

  double _tenSecondsInMilliseconds = 10 * 1000;
  double _shortSkipAmountMilliseconds = 15 * 1000;
  double _regularSkipAmountMilliseconds =
      30 * 1000; // TODO: maybe move to const folder

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

  /// current position adaptation
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

  Future<void> play() async => await _podcastController.play();

  pause() => null;

  Future<void> seekTo(double position) =>
      _podcastController.seekTo(Duration(milliseconds: (position).toInt()));

  Future<void> skipForward() => this
      .seekTo(this.position + _regularSkipAmountMilliseconds); // milliseconds

  Future<void> skipBackward() =>
      this.seekTo(this.position - _regularSkipAmountMilliseconds);

  /// Flexible skip function
  /// - if rewindSkip flag set to true then skipSize is applied as negative
  /// - might change this to be purely an internal helper
  Future<void> skip({bool rewindSkip = false, double skipSize = 30 * 1000}) =>
      (!rewindSkip)
          ? this.seekTo(this.position + skipSize)
          : this.seekTo(this.position - skipSize);
}
