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
}
