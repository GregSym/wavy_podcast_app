import 'package:better_player/better_player.dart';
import 'package:flutter_podcast_app/controllers/generic_player_controller.dart';
import 'package:flutter_podcast_app/controllers/web_player_controller.dart';
import 'package:flutter_podcast_app/functions/platform_analysis.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'mobile_player_controller.dart';

/// Composition class for getting media player into a semi-multi-platform state
/// - this is a bad way to do this, but it's the easiest way to manage it
/// - - So maybe it's not the absolute worst?
class PodcastPlayerController extends GenericController {
  GenericController _podcastController = PlatformAnalysis.isMobile
      ? MobilePlayerController()
      : WebPlayerController()
    ..setup();

  @override
  // TODO: implement isInitialized
  bool get isInitialized => _podcastController.isInitialized;

  @override
  // TODO: implement isPlaying
  bool get isPlaying => _podcastController.isPlaying;

  @override
  // TODO: implement position
  double get position => _podcastController.position;
  @override
  set position(double position) {
    super.position = position;
    notifyListeners();
  }

  @override
  // TODO: implement duration
  double get duration => _podcastController.duration;

  @override
  set duration(double duration) {
    super.duration = duration;
    notifyListeners();
  }

  @override
  Future play() async =>
      await _podcastController.play().then((_) => notifyListeners());

  @override
  Future pause() async =>
      await _podcastController.pause().then((_) => notifyListeners());

  @override
  Future<void> adaptiveSeekFunction(double position) async => _podcastController
      .adaptiveSeekFunction(position)
      .then((_) => notifyListeners());

  @override
  // TODO: implement events
  get events => _podcastController.events;

  @override
  set currentTrack(RssItem rssItem) {
    super.currentTrack = rssItem;
    _podcastController.currentTrack = rssItem;
  }

  @override
  void setupListeners() {
    if (PlatformAnalysis.isMobile) {
      _podcastController.podcastController.addEventsListener((events) {
        if (events.betterPlayerEventType == BetterPlayerEventType.progress)
          notifyListeners();
        return;
      });
    }

    // _podcastController.podcastController
    //   ..onPlayerStateChanged.listen((_) => notifyListeners());
    // _podcastController.podcastController
    //   ..onAudioPositionChanged.listen((progressDuration) {
    //     // _position = progressDuration.inMilliseconds.toDouble();
    //     notifyListeners();
    //   });
    // _podcastController.podcastController
    //   ..onDurationChanged.listen((durationDuration) {
    //     // _duration = durationDuration.inMilliseconds.toDouble();
    //     notifyListeners();
    //   });
  }
}
