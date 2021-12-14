import 'package:flutter_podcast_app/functions/network_operations.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

class PodcastViewModel {
  List<String> urlList;
  List<PodcastInfo> feedList;
  late PodcastInfo selectedFeed;
  List<PodcastInfo> itemList = [];
  PodcastInfo? selectedItem;

  /// Model to draw from for displaying podcast info
  PodcastViewModel({required this.urlList, required this.feedList}) {
    selectedFeed = this.feedList.first;
    // selectedItem = this.itemList.first;
    this.initMethod();
  }

  Future<void> initMethod() async {
    await this.createFeedList(); // so, I prolly don't need to do this here?
    this.createItemList();
  }

  Future<void> createFeedList() async {
    // List<PodcastInfo> _tempFeedList = [];
    // for (String url in this.urlList) {
    //   RssFeed rssFeed = await NetworkOperations.parseUrl(url);
    //   if (rssFeed.items != null)
    //     _tempFeedList.add(PodcastInfo(
    //         link: url, rssFeed: rssFeed, rssItem: rssFeed.items!.first));
    // }
    // this.feedList = _tempFeedList;

    // sort feeds by last publish date
    this.feedList.sort((feedOne, feedTwo) =>
        (feedOne.rssFeed!.items != null && feedTwo.rssFeed!.items != null)
            ? feedTwo.rssFeed!.items!.first.pubDate!
                .compareTo(feedOne.rssFeed!.items!.first.pubDate!)
            : feedTwo.rssFeed!.syndication!.updateBase!
                .compareTo(feedOne.rssFeed!.syndication!.updateBase!));
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

class FeedFocusViewModel extends PodcastViewModel {
  FeedFocusViewModel(
      {required List<String> urlList, required List<PodcastInfo> feedList})
      : super(urlList: urlList, feedList: feedList);
  @override
  void createItemList() {
    if (this.selectedFeed.rssFeed != null &&
        this.selectedFeed.rssFeed!.items != null)
      this.itemList = this
          .selectedFeed
          .rssFeed!
          .items!
          .map((item) => PodcastInfo(
              link: this.selectedFeed.link,
              rssFeed: this.selectedFeed.rssFeed,
              rssItem: item))
          .toList();
  } // don't sort the items
}
