import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:flutter_podcast_app/models/podcast_src.dart';
import 'package:flutter_podcast_app/services/database_manager.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class Podcast with ChangeNotifier {
  final BuildContext context;
  Podcast(this.context);
  bool _loading = false;
  Map<String, RssFeed?> _multiFeed = {};
  RssFeed? _feed;
  PodcastInfo? _selectedItem;
  //late Map<String, bool> downloadStatus; // part of the excluded download
  String url =
      'https://feeds.simplecast.com/wjQvYtdl'; //mbmbam probably exists, right?
  String _mockUrl = 'https://feeds.simplecast.com/wjQvYtdl';

  PodcastSource _source = PodcastSource(srcLink: mockSrcs);
  PodcastSource get sources => _source;

  bool get isLoading => _loading;

  void setLoading() {
    if (!_loading) {
      _loading = true;
      notifyListeners();
    }
  }

  RssFeed? get feed => _feed;
  void parse() async {
    notifyListeners();
    final res = await http.get(Uri.parse(
        url)); // remember to parse the url string because they made the package worse?
    final strXml = res.body;
    _feed = RssFeed.parse(strXml);
    if (_loading) _loading = false;
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

  showExplore() {
    this._source = PodcastSource(srcLink: mockSrcs);
    this.url = this._mockUrl;
    this.parse();
    this.multiParse();
  }

  showSubscriptions() {
    this._source =
        PodcastSource(srcLink: context.read<DataBaseManager>().subscriptions);
    this.url = this._source.srcLink.first;
    this.parse();
    this.multiParse();
  }

  List<PodcastInfo> get subscriptionFeed {
    List<PodcastInfo> _subscriptionFeed = [];
    for (MapEntry<String, RssFeed?> feedEntry in this._multiFeed.entries) {
      if (feedEntry.value != null) {
        if (feedEntry.value!.items != null) {
          for (RssItem rssItem in feedEntry.value!.items!) {
            subscriptionFeed.add(PodcastInfo(
                link: feedEntry.key,
                rssFeed: feedEntry.value,
                rssItem: rssItem));
          }
        }
      }
    }
    return _subscriptionFeed
      ..sort((itemOne, itemTwo) =>
          (itemOne.rssItem!.pubDate != null && itemTwo.rssItem!.pubDate != null)
              ? itemOne.rssItem!.pubDate!
                  .compareTo(itemTwo.rssItem!.pubDate!) // main
              : itemOne.rssFeed!.syndication!.updateBase!.compareTo(
                  itemTwo.rssFeed!.syndication!.updateBase!)); // fallback
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
