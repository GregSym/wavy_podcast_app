import 'package:flutter_podcast_app/controllers/generic_player_controller.dart';
import 'package:flutter_podcast_app/controllers/mobile_player_controller.dart';
import 'package:flutter_podcast_app/controllers/web_player_controller.dart';
import 'package:flutter_podcast_app/functions/platform_analysis.dart';
import 'package:webfeed/domain/rss_item.dart';

/// Unified Controller for adapting to different platforms
/// and their respective player abilities
class UnifiedPlayerController extends GenericController {
  final GenericController _podcastController = PlatformAnalysis.isMobile
      ? MobilePlayerController()
      : WebPlayerController();

  @override
  bool get isInitialized => _podcastController.isInitialized;

  @override
  bool get isPlaying => _podcastController.isPlaying;

  @override
  double get position => _podcastController.position;

  @override
  double get duration => _podcastController.duration;

  @override
  Future play() async => await _podcastController.play();

  @override
  Future pause() async => await _podcastController.pause();

  @override
  Future<void> adaptiveSeekFunction(double position) async =>
      _podcastController.adaptiveSeekFunction(position);

  @override
  get events => _podcastController.events;

  @override
  set currentTrack(RssItem rssItem) {
    super.currentTrack = rssItem;
    _podcastController.currentTrack = rssItem;
  }

  @override
  void setupListeners() => _podcastController.setupListeners();
}
