import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;

class NetworkOperations {
  static Future<RssFeed> parseUrl(String url) async {
    final res = await http.get(Uri.parse(
        url)); // remember to parse the url string because they made the package worse?
    final strXml = res.body;
    return RssFeed.parse(strXml);
  }
}
