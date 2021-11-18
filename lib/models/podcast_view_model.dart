import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:webfeed/domain/rss_item.dart';

class PodcastViewModel {
  List<String> urlList;
  List<PodcastInfo> feedList;
  late PodcastInfo selectedFeed;
  List<PodcastInfo> itemList = [];
  late PodcastInfo selectedItem;

  /// Model to draw from for displaying podcast info
  PodcastViewModel({required this.urlList, required this.feedList}) {
    selectedFeed = this.feedList.first;
    selectedItem = this.itemList.first;
    this.createItemList();
  }

  void createItemList() {
    for (PodcastInfo _givenFeed in this.feedList) {
      if (_givenFeed.rssFeed != null) break;
      if (_givenFeed.rssFeed!.items == null) break;
      for (RssItem rssItem in _givenFeed.rssFeed!.items!) {
        this.itemList.add(PodcastInfo(
            link: _givenFeed.link,
            rssFeed: _givenFeed.rssFeed,
            rssItem: rssItem));
      }
    }
    // sort the items from newest to oldest
    this.itemList.sort((itemOne, itemTwo) =>
        (itemOne.rssItem!.pubDate != null && itemTwo.rssItem!.pubDate != null)
            ? itemTwo.rssItem!.pubDate!
                .compareTo(itemOne.rssItem!.pubDate!) // main
            : itemTwo.rssFeed!.syndication!.updateBase!
                .compareTo(itemOne.rssFeed!.syndication!.updateBase!));
  }
}
