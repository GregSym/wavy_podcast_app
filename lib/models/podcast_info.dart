import 'package:flutter_podcast_app/functions/network_operations.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

/// basic class containing all critical info noted so far
class PodcastInfo {
  String? link;
  RssFeed? rssFeed;
  RssItem? rssItem;

  PodcastInfo({this.link, this.rssFeed, this.rssItem}) {
    this.fillInFeed();
  }

  fillInFeed() async {
    if (this.link == null) return;
    if (this.rssFeed == null)
      rssFeed = await NetworkOperations.parseUrl(this.link!);
  }
}
// TODO: replace previous attempts at passing info about podcasts with this
// struct thing

class PodcastWrapper {
  PodcastInfo podcast;
  PodcastWrapper({required this.podcast}) {
    assert(podcast.link != null);

    if (podcast.rssFeed == null) {
      // parse
    }

    if (podcast.rssItem == null) {
      podcast.rssItem = podcast.rssFeed!.items!.first;
    }
  }
}
