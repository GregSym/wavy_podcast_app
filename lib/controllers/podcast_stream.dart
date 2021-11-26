import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_podcast_app/functions/network_operations.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:flutter_podcast_app/models/podcast_src.dart';
import 'package:flutter_podcast_app/models/podcast_view_model.dart';
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
  PodcastViewModel? _podcastViewModel;
  //late Map<String, bool> downloadStatus; // part of the excluded download
  String url =
      'https://feeds.simplecast.com/wjQvYtdl'; //mbmbam probably exists, right?
  String _mockUrl = 'https://feeds.simplecast.com/wjQvYtdl';

  PodcastSource _source = PodcastSource(srcLink: mockSrcs);
  PodcastSource get sources => _source;

  PodcastViewModel get podcastViewModel =>
      this._podcastViewModel ??
      PodcastViewModel(urlList: this._source.srcLink, feedList: []);

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
    if (this._source.srcLink.isEmpty) return;
    this.url = this._source.srcLink.first;
    this.parse();
    this.multiParse();
  }

  Future<List<PodcastInfo>> get subscriptionFeed async {
    List<PodcastInfo> _subscriptionFeed = [];
    List<PodcastInfo> _subscriptionFeedSources = [];
    if (context.read<DataBaseManager>().subscriptions.isEmpty) return [];

    for (Future<PodcastInfo> feedEntry in context
        .read<DataBaseManager>()
        .subscriptions
        .map((link) async => await PodcastInfo(
            link: link, rssFeed: await NetworkOperations.parseUrl(link)))) {
      PodcastInfo _feed = await feedEntry;
      if (_feed.rssFeed != null) {
        if (_feed.rssFeed!.items != null) {
          for (RssItem rssItem in _feed.rssFeed!.items!) {
            _subscriptionFeed.add(PodcastInfo(
                link: _feed.link, rssFeed: _feed.rssFeed, rssItem: rssItem));
          }
        }
      }
    }
    _subscriptionFeed.sort((itemOne, itemTwo) => (itemOne.rssItem!.pubDate !=
                null &&
            itemTwo.rssItem!.pubDate != null)
        ? itemTwo.rssItem!.pubDate!.compareTo(itemOne.rssItem!.pubDate!) // main
        : itemTwo.rssFeed!.syndication!.updateBase!
            .compareTo(itemOne.rssFeed!.syndication!.updateBase!)); // fallback
    return _subscriptionFeed;
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
