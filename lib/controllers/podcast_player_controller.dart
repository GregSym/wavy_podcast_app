import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_podcast_app/constants/images_resources.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

/// Composition class for getting media player into a semi-multi-platform state
/// - this is a bad way to do this, but it's the easiest way to manage it
/// - - So maybe it's not the absolute worst?
class PodcastPlayerController with ChangeNotifier {
  BetterPlayerController _podcastController =
      BetterPlayerController(BetterPlayerConfiguration());

  RssItem? _currentTrack;
  RssFeed? _currentFeed;
  String? _fallbackImgUri = ImgResources.fallbackImgUri;

  //double _tenSecondsInMilliseconds = 10 * 1000;
  //double _shortSkipAmountMilliseconds = 15 * 1000;
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
  // GETTERS
  /// current position adaptation
  double get position =>
      _podcastController.videoPlayerController!.value.position.inMilliseconds
          .toDouble(); // TODO: add a null check here

  double get duration =>
      _podcastController.videoPlayerController!.value.duration!.inMilliseconds
          .toDouble(); // TODO: add a null check here

  get events => null;

  // SETTERS
  RssFeed? get currentFeed => _currentFeed;
  set currentFeed(RssFeed? rssFeed) {
    _currentFeed = rssFeed;
    if (rssFeed == null) {
      return;
    }
    if (rssFeed.image == null) return;
    _fallbackImgUri = rssFeed.image!.url;
  }

  /// method for getting the current track
  RssItem get currentTrack => _currentTrack!;

  /// Method for setting the current track
  set currentTrack(RssItem rssItem) {
    // set the controller's reference to the arg
    _currentTrack = rssItem;
    // null checks
    if (rssItem.enclosure == null) return; // this won't work without this
    if (rssItem.enclosure!.url == null) return;
    // main setter logic
    // might want to reuse these fields in other objects, maybe
    String audioSrc = rssItem.enclosure!.url!;
    String? trackTitle = rssItem.title;
    String? trackAuthor = rssItem.author;
    String? trackImage;
    if (rssItem.itunes != null) {
      if (rssItem.itunes!.image != null)
        trackImage = FeedAnalysisFunctions.hasIndividualEpisodeImage(rssItem)
            ? rssItem.itunes!.image!.href
            : _fallbackImgUri;
    }

    _podcastController.setupDataSource(
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

    notifyListeners();
  }

  // METHODS

  togglePlay() => (_podcastController.isPlaying()!)
      ? _podcastController.pause().then((value) => notifyListeners())
      : _podcastController
          .play()
          .then((value) => notifyListeners()); // TODO: add a null check here

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

  crudeListener() => _podcastController.addEventsListener((events) {
        if (events.betterPlayerEventType == BetterPlayerEventType.progress)
          notifyListeners();
      });
}
