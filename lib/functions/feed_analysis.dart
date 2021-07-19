import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

bool hasIndividualEpisodeImage(RssItem rssItem) {
  if (rssItem.itunes != null) {
    if (rssItem.itunes!.image != null) {
      if (rssItem.itunes!.image!.href != null) return true;
    }
  }
  return false;
}
