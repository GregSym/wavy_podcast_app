import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:webfeed/domain/rss_item.dart';

/// class to hold the subscription data type and maybe later for
/// managing multiple storage options
class PodcastSubscriptions {
  /// list of links to podcasts tied to Feeds
  List<PodcastInfo> subscriptions;
  List<PodcastInfo> _subscriptionFeed = [];
  PodcastSubscriptions({required this.subscriptions}) {
    this.createSubscriptionFeed();
  }

  List<PodcastInfo> get subscriptionFeed => this._subscriptionFeed;

  void newSubscriptions(List<PodcastInfo> newSubscriptions) {
    this.subscriptions = newSubscriptions;
    this.createSubscriptionFeed();
  }

  void createSubscriptionFeed() {
    for (PodcastInfo subscription in this.subscriptions) {
      if (subscription.link != null) {
        if (subscription.rssFeed!.items != null) {
          for (RssItem rssItem in subscription.rssFeed!.items!) {
            this._subscriptionFeed.add(PodcastInfo(
                link: subscription.link,
                rssFeed: subscription.rssFeed,
                rssItem: rssItem));
          }
        }
      }
    }
    _subscriptionFeed
      ..sort((itemOne, itemTwo) =>
          (itemOne.rssItem!.pubDate != null && itemTwo.rssItem!.pubDate != null)
              ? itemOne.rssItem!.pubDate!
                  .compareTo(itemTwo.rssItem!.pubDate!) // main
              : itemOne.rssFeed!.syndication!.updateBase!.compareTo(
                  itemTwo.rssFeed!.syndication!.updateBase!)); // fallback
  }
}
