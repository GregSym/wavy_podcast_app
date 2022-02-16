import 'package:better_player/better_player.dart';
import 'package:flutter_podcast_app/controllers/generic_player_controller.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/functions/null_checks.dart';
import 'package:flutter_podcast_app/models/audio_player_types.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:webfeed/domain/rss_item.dart';

class MobilePlayerController extends GenericController {
  BetterPlayerController _mobileController =
      BetterPlayerController(BetterPlayerConfiguration());

  @override
  // TODO: implement podcastController
  get podcastController =>
      AudioPlayerTypes(betterPlayerController: _mobileController);

  @override
  // TODO: implement isInitialized
  bool get isInitialized =>
      NullChecks.checkFunction<bool>(_mobileController.isVideoInitialized);

  @override
  // TODO: implement isPlaying
  bool get isPlaying =>
      NullChecks.checkFunction<bool>(_mobileController.isPlaying);

  @override
  // TODO: implement position
  double get position => _mobileController.videoPlayerController == null
      ? 0.0
      : _mobileController.videoPlayerController!.value.position.inMilliseconds
          .toDouble();

  @override
  // TODO: implement duration
  double get duration => _mobileController.videoPlayerController == null
      ? 0.0
      : _mobileController.videoPlayerController!.value.duration == null
          ? 1.0
          : _mobileController
              .videoPlayerController!.value.duration!.inMilliseconds
              .toDouble();

  @override
  // TODO: implement buffered
  double get buffered => _mobileController
      .videoPlayerController!.value.buffered.last.end.inMilliseconds
      .toDouble();

  @override
  Future play() async => await _mobileController.play();

  @override
  Future pause() async => await _mobileController.pause();

  @override
  Future<void> adaptiveSeekFunction(double position) =>
      _mobileController.seekTo(Duration(milliseconds: position.toInt()));

  @override
  // TODO: implement events
  get events => _mobileController.addEventsListener((events) => events);

  @override
  set currentTrack(RssItem rssItem) {
    super.currentTrack = rssItem;

    String audioSrc = rssItem.enclosure!.url!;
    String? trackTitle = rssItem.title;
    String? trackAuthor = FeedAnalysisFunctions.authorFromItem(rssItem);
    String? trackImage = FeedAnalysisFunctions.imageFromPodcastInfo(
        PodcastInfo(rssFeed: this.currentFeed, rssItem: this.currentTrack));
    // if (rssItem.itunes != null) {
    //   if (rssItem.itunes!.image != null)
    //     trackImage = FeedAnalysisFunctions.hasIndividualEpisodeImage(rssItem)
    //         ? rssItem.itunes!.image!.href
    //         : this.currentFeed!.image!.url ??
    //             this.currentFeed!.itunes!.image!.href ??
    //             ImgResources.fallbackImgUri;
    // }
    _mobileController.setupDataSource(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        audioSrc,
        notificationConfiguration: BetterPlayerNotificationConfiguration(
          showNotification: true,
          title: trackTitle,
          author: trackAuthor,
          imageUrl: trackImage,
        ),
      ),
    );
  }

  @override
  void setupListeners() {
    // TODO: implement setupListeners
    _mobileController.addEventsListener((events) {
      if (events.betterPlayerEventType == BetterPlayerEventType.progress)
        notifyListeners();
    });
  }
}
