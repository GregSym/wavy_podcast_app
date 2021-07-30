import 'dart:math';

import 'package:flutter_podcast_app/constants/images_resources.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

class FeedAnalysisFunctions {
  static bool hasIndividualEpisodeImage(RssItem rssItem) {
    if (rssItem.itunes != null) {
      if (rssItem.itunes!.image != null) {
        if (rssItem.itunes!.image!.href != null) return true;
      }
    }
    return false;
  }

  static String imageFromItem(RssItem? rssItem) => rssItem == null
      ? ImgResources.fallbackImgUri
      : rssItem.itunes!.image!.href ?? ImgResources.fallbackImgUri;

  static String imageFromFeed(RssFeed? rssFeed) => rssFeed == null
      ? ImgResources.fallbackImgUri
      : rssFeed.image!.url ??
          rssFeed.itunes!.image!.href ??
          ImgResources.fallbackImgUri;

  /// generates a valid image uri for a given podcast feed and item
  /// falls back to the public domain default in constants
  static String imageFromPodcastInfo(PodcastInfo podcastInfo) {
    String uri =
        FeedAnalysisFunctions.hasIndividualEpisodeImage(podcastInfo.rssItem!)
            ? FeedAnalysisFunctions.imageFromItem(podcastInfo.rssItem)
            : FeedAnalysisFunctions.imageFromFeed(podcastInfo.rssFeed);
    return uri;
  }

  /// gets the next item for the player to play
  /// - has 2 flags:
  /// - - getNewerItems (default: false) - go from oldest to newest if true,
  /// otherwise vice versa
  /// - - shuffle (default: false) - sets the selection to shuffle to random
  /// items within the bounds of the item range in this single feed
  /// - - shuffle overrides directional flag above
  /// - navigates a single feed, may be invoked as part of the system for
  /// navigating more complex feeds later
  static RssItem nextItem(RssItem rssItem, RssFeed rssFeed,
      {bool getNewerItems = false, bool shuffle = false}) {
    RssItem? nextItem;

    /// the number of the item - 0 is the most recent item
    int loc = 0;
    if (rssFeed.items == null) return rssItem;
    if (shuffle) {
      loc = Random().nextInt(rssFeed.items!.length + 1); // nextInt is exclusive
      // of the number passed to args
      nextItem = rssFeed.items!.elementAt(loc);
      return nextItem;
    }

    loc = rssFeed.items!
        .asMap()
        .entries
        .where((itemMap) => itemMap.value.title == rssItem.title)
        .first
        .key;

    if (getNewerItems) {
      if (loc - 1 >= 0)
        nextItem = rssFeed.items!.elementAt(loc - 1);
      else
        nextItem = rssItem;
    }
    if (loc + 1 <= rssFeed.items!.length) {
      // fun fact: i++ doesn't work for this
      nextItem = rssFeed.items!.elementAt(loc + 1);
      print(nextItem.title);
    } else {
      nextItem = rssItem;
    }
    return nextItem;
  }
}
