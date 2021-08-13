import 'package:webfeed/domain/rss_item.dart';

class NullChecks {
  static T checkFunction<T>(Function func) => func() == null ? false : func();

  /// returns true if item exists, else false
  static bool checkRssItem(RssItem? rssItem) => rssItem == null ? false : true;
}
