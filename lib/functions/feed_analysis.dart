import 'dart:math';

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
    if (loc + 1 <= rssFeed.items!.length)
      // fun fact: i++ doesn't work for this
      nextItem = rssFeed.items!.elementAt(loc + 1);
    else
      nextItem = rssItem;
    return nextItem;
  }
}
