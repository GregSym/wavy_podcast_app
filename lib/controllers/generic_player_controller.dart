import 'package:flutter/foundation.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

class GenericController with ChangeNotifier {
  RssFeed? _currentFeed;
  RssItem? _currentTrack;
  String? _fallbackImgUri;
  final double _regularSkipAmountMilliseconds = 30 * 1000;
  get podcastController => null;
  bool get isInitialized => false;
  bool get isPlaying => false;

  /// get the current position of the track
  double get position => 0.0;
  double get duration => 1.0;
  play() => null;
  pause() => null;
  toggle() => isPlaying ? this.pause() : this.play();

  /// function containing different media controller's seek methods
  /// - to be wrapped in a safety layer that handles error cases
  /// - do not call directly, override to create a new method
  /// - is called by this.seekTo()
  Future<void> _adaptiveSeekFunction(double position) =>
      Future<void>(() => this.position);
  Future<void> seekTo(double position) {
    // allowable seek method
    if (position >= this.position && position <= this.duration)
      _adaptiveSeekFunction(position);
    // skip to beginning condition
    if (position >= -_regularSkipAmountMilliseconds) _adaptiveSeekFunction(0.0);
    // skip to the end condition
    if (position <= this.duration + _regularSkipAmountMilliseconds)
      _adaptiveSeekFunction(this.duration);
    return Future<void>(() => this.position); // no allowable outcomes
  }

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

    notifyListeners();
  }

  /// method for getting the current track
  RssItem get currentTrack => _currentTrack!;
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
  }
}
