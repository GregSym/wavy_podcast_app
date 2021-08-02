import 'package:flutter/foundation.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:flutter_podcast_app/models/podcast_src.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class Podcast with ChangeNotifier {
  Map<String, RssFeed?> _multiFeed = {};
  RssFeed? _feed;
  PodcastInfo? _selectedItem;
  PodcastInfo? _podcastInfo;
  //late Map<String, bool> downloadStatus; // part of the excluded download
  String url =
      'https://feeds.simplecast.com/wjQvYtdl'; //mbmbam probably exists, right?

  PodcastSource _source = PodcastSource(srcLink: mockSrcs);
  PodcastSource get sources => _source;

  RssFeed? get feed => _feed;
  void parse() async {
    final res = await http.get(Uri.parse(
        url)); // remember to parse the url string because they made the package worse?
    final strXml = res.body;
    _feed = RssFeed.parse(strXml);
    notifyListeners();
  }

  PodcastInfo? get selectedItem => _selectedItem;
  set selectedItem(PodcastInfo? value) {
    _selectedItem = value;
    notifyListeners();
  }

  Map<String, RssFeed?> get multiFeed => _multiFeed;
  void multiParse() async {
    for (String uri in _source.srcLink) {
      final res = await http.get(Uri.parse(
          uri)); // remember to parse the url string because they made the package worse?
      final strXml = res.body;
      _multiFeed.addEntries({uri: RssFeed.parse(strXml)}.entries);
    }

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
