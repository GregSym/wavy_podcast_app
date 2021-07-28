import 'package:flutter/foundation.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class Podcast with ChangeNotifier {
  RssFeed? _feed;
  RssItem? _selectedItem;
  //late Map<String, bool> downloadStatus; // part of the excluded download
  final String url =
      'https://feeds.simplecast.com/wjQvYtdl'; //mbmbam probably exists, right?

  RssFeed? get feed => _feed;
  void parse() async {
    final res = await http.get(Uri.parse(
        url)); // remember to parse the url string because they made the package worse?
    final strXml = res.body;
    _feed = RssFeed.parse(strXml);
    notifyListeners();
  }

  RssItem? get selectedItem => _selectedItem;
  set selectedItem(RssItem? value) {
    _selectedItem = value;
    print(_selectedItem!.title);
    notifyListeners();
  }

  /*
  void download(RssItem item) async {
    final client = http.Client();
    final req = http.Request("GET", Uri.parse(item.enclosure.url));
    final res = await client.send(req);
    if (res.statusCode != 200) {
      throw Exception('Unexpected HTTP code: ${res.statusCode}');
    }
    res.stream.listen((bytes) {
      print("Received ${bytes.length} bytes");
    });
    final file = File(await _getDownloadDirectory());
    res.stream
        .pipe(file.openWrite())
        .whenComplete(() => print('Downloading complete'));
  }
  */
}
