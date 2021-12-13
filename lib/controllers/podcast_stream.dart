import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_podcast_app/functions/network_operations.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:flutter_podcast_app/models/podcast_src.dart';
import 'package:flutter_podcast_app/models/podcast_view_model.dart';
import 'package:flutter_podcast_app/services/database_manager.dart';
import 'package:flutter_podcast_app/services/state_trackers.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

/// flag for view model generation
enum SelectedGeneration { all, explore, subscriptions }

/// Global factory for PodcastViewModels - I might need this elsewhere?
/// - accepts a SelectedGeneration enum to request subclasses of the generic
/// PodcastViewModel class - explore returns a FeedFocusViewModel with items from
/// a single feed
Future<PodcastViewModel> podcastViewModelFactory(List<String> srcs,
    [SelectedGeneration selectedGeneration = SelectedGeneration.all]) async {
  List<Future<PodcastInfo>> _futureFeedList = await srcs.map((src) async {
    var feed = await NetworkOperations.parseUrl(src);
    return await PodcastInfo(
      link: src,
      rssFeed: feed,
      rssItem: feed.items!.first,
    );
  }).toList();
  List<PodcastInfo> _feedList = [];
  for (Future<PodcastInfo> futureFeed in _futureFeedList)
    _feedList.add(await futureFeed);
  if (selectedGeneration == SelectedGeneration.explore)
    return FeedFocusViewModel(
        urlList: srcs, feedList: _feedList); // alt view model
  return PodcastViewModel(urlList: srcs, feedList: _feedList);
}

class Podcast with ChangeNotifier {
  final BuildContext context;
  Podcast(this.context);
  bool _loading = false;
  Map<String, RssFeed?> _multiFeed = {};
  RssFeed? _feed;
  PodcastInfo? _selectedItem;
  PodcastViewModel? _podcastViewModel;
  PodcastViewModel? _subscriptionViewModel;
  PodcastViewModel? _exploreViewModel;
  //late Map<String, bool> downloadStatus; // part of the excluded download
  String url =
      'https://feeds.simplecast.com/wjQvYtdl'; //mbmbam probably exists, right?
  String _mockUrl = 'https://feeds.simplecast.com/wjQvYtdl';

  PodcastSource _source = PodcastSource(srcLink: mockSrcs);
  PodcastSource get sources => _source;

  PodcastViewModel? get podcastViewModel =>
      context.read<StateTracker>().feedSelection == FeedSelection.explore
          ? this._exploreViewModel
          : this._subscriptionViewModel;

  /// generic tool for generating view models of podcasts from a link to their
  /// feed stored as a string
  Future<PodcastViewModel> _generateViewModel(List<String> urls) async {
    List<PodcastInfo> _exploreFeeds = [];
    for (Future<RssFeed> futureFeed
        in urls.map((url) async => await NetworkOperations.parseUrl(url))) {
      RssFeed feed = await futureFeed;
      if (feed.items != null)
        _exploreFeeds.add(PodcastInfo(
          link: url,
          rssFeed: feed,
          rssItem: feed.items!.first,
        ));
    }
    return PodcastViewModel(urlList: urls, feedList: _exploreFeeds);
  }

  /// Generates all view models, by default. Should be called on start up
  void generateViewModels(
      [SelectedGeneration selectedGeneration = SelectedGeneration.all,
      bool notifyOnCompletion = true]) async {
    if (selectedGeneration == SelectedGeneration.all ||
        selectedGeneration == SelectedGeneration.explore)
      this._exploreViewModel = await this._generateViewModel(mockSrcs);
    if (selectedGeneration == SelectedGeneration.all ||
        selectedGeneration == SelectedGeneration.subscriptions)
      this._subscriptionViewModel = await this._generateViewModel(
          this.context.read<DataBaseManager>().subscriptions);
    if (notifyOnCompletion) notifyListeners();
  }

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

  /// Sets up links to higher order providers
  setupListeners() {
    // links to Database Management
    this.context.read<DataBaseManager>().addListener(() {
      // regenerate subscription view model on change to subscription list
      List<String> _subs = context.read<DataBaseManager>().subscriptions;
      if (!(this._subscriptionViewModel!.urlList.length == _subs.length &&
          this._subscriptionViewModel!.urlList.contains(_subs.length))) {
        this.generateViewModels(
            SelectedGeneration.subscriptions,
            // notify listeners when subscription feed is selected as those
            // will be on screen under that circumstance
            context.read<StateTracker>().feedSelection ==
                FeedSelection.subscription);
      }
    });
    // links to the State Tracker object
    this.context.read<StateTracker>().addListener(() {
      // propogate listener update in response to the state
      notifyListeners();
    });
  }
}

/// alt class to highlight how the new podcast controller ought to work once I'm
/// done with it
class _PodcastStreamAlt with ChangeNotifier {
  final BuildContext context;
  _PodcastStreamAlt({required this.context});
  PodcastViewModel? _podcastViewModel;
  PodcastViewModel? _subscriptionViewModel;
  PodcastViewModel? _exploreViewModel;

  PodcastViewModel? get podcastViewModel =>
      _podcastViewModel; // allow null here

  generateViewModels() async {
    this._exploreViewModel =
        await podcastViewModelFactory(mockSrcs, SelectedGeneration.explore);
    this._subscriptionViewModel = await podcastViewModelFactory(
        this.context.read<DataBaseManager>().subscriptions);
    notifyListeners();
  }
}
