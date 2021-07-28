import 'package:better_player/better_player.dart';
import 'package:flutter_podcast_app/controllers/generic_player_controller.dart';
import 'package:flutter_podcast_app/controllers/web_player_controller.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/functions/platform_analysis.dart';
import 'package:just_audio/just_audio.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'mobile_player_controller.dart';

/// Composition class for getting media player into a semi-multi-platform state
/// - this is a bad way to do this, but it's the easiest way to manage it
/// - - So maybe it's not the absolute worst?
class PodcastPlayerController extends GenericController {
  GenericController _podcastController = PlatformAnalysis.isMobile
      ? MobilePlayerController()
      : WebPlayerController();

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
    _podcastController.position = position;
    notifyListeners();
  }

  @override
  // TODO: implement duration
  double get duration => _podcastController.duration;

  @override
  set duration(double duration) {
    _podcastController.duration = duration;
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
    // _podcastController.setupListeners(); // this doesn't work/do anything

    // handle setting up listeners for the mobile version
    if (PlatformAnalysis.isMobile) {
      _podcastController.podcastController.betterPlayerController!
          .addEventsListener((events) {
        if (events.betterPlayerEventType == BetterPlayerEventType.progress)
          notifyListeners();
        if (events.betterPlayerEventType == BetterPlayerEventType.finished) {
          this.setNewTrack();

          notifyListeners();
        }
        return;
      });
    }

    // handle setting up listeners for the web version
    if (_podcastController.runtimeType == WebPlayerController) {
      _podcastController.podcastController.audioPlayer!.positionStream
          .listen((position) {
        notifyListeners();
      });
      _podcastController.podcastController.audioPlayer!.playerStateStream
          .listen((state) {
        if (state.processingState == ProcessingState.completed) {
          this.setNewTrack();
          notifyListeners();
        }
      });
    }
  }
}
