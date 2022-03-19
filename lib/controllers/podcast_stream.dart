import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/functions/network_operations.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:flutter_podcast_app/models/podcast_src.dart';
import 'package:flutter_podcast_app/models/podcast_view_model.dart';
import 'package:flutter_podcast_app/services/database_manager.dart';
import 'package:flutter_podcast_app/services/state_trackers.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';

/// flag for view model generation
enum SelectedGeneration { all, explore, subscriptions }

/// Stream implementation of PodcastViewModel Factory
Stream<PodcastViewModel?> podcastViewModelStream(List<String> srcs,
    [SelectedGeneration selectedGeneration = SelectedGeneration.all]) async* {
  List<String> _badSrcs = [];
  List<PodcastInfo> _podcastInfoFutures = [];
  for (String src in srcs) {
    print(src);
    try {
      var feed = await NetworkOperations.parseUrl(src);
      if (feed.items != null) {
        _podcastInfoFutures.add(PodcastInfo(
          link: src,
          rssFeed: feed,
          rssItem: feed.items!.first,
        ));
      }
    } on Exception catch (error) {
      // exception goes off inside the RssFeed object?
      print("$error from stream version");
      _badSrcs.add(src);
      // return PodcastInfo();
    }
    srcs.removeWhere(
        (src) => _badSrcs.contains(src)); // remove list of bad srcs
    yield selectedGeneration == SelectedGeneration.explore
        ? FeedFocusViewModel(
            urlList: srcs.toSet(), feedList: _podcastInfoFutures)
        : PodcastViewModel(
            urlList: srcs.toSet(), feedList: _podcastInfoFutures);
  }
}

/// Global factory for PodcastViewModels - I might need this elsewhere?
/// - accepts a SelectedGeneration enum to request subclasses of the generic
/// PodcastViewModel class - explore returns a FeedFocusViewModel with items from
/// a single feed
Future<PodcastViewModel?> podcastViewModelFactory(List<String> srcs,
    [SelectedGeneration selectedGeneration = SelectedGeneration.all]) async {
  List<String> _badSrcs = [];
  Iterable<Future<PodcastInfo>> _futureFeedList = await srcs.map((src) async {
    try {
      print("parsing: $src");
      var feed = await NetworkOperations.parseUrl(src);
      if (feed.items != null) {
        return await PodcastInfo(
          link: src,
          rssFeed: feed,
          rssItem: feed.items!.first,
        );
      }
      return PodcastInfo();
    } on Exception catch (error) {
      // exception goes off inside the RssFeed object?
      print("$error: from factory");
      _badSrcs.add(src);
      return PodcastInfo();
    }
  });
  srcs.removeWhere((src) => _badSrcs.contains(src)); // remove list of bad srcs
  // List<PodcastInfo> _feedList = [];
  print("Starting the request batch for $selectedGeneration! --------------");
  List<PodcastInfo> _feedList = await Future.wait<PodcastInfo>(_futureFeedList);
  // for (Future<PodcastInfo> futureFeed in _futureFeedList) {
  //   var awaitedFeed = await futureFeed;
  //   if (awaitedFeed.rssFeed != null) _feedList.add(awaitedFeed);
  // }
  if (_feedList.isNotEmpty) {
    if (selectedGeneration == SelectedGeneration.explore) {
      return FeedFocusViewModel(urlList: srcs.toSet(), feedList: _feedList);
    } // alt view model
    return PodcastViewModel(urlList: srcs.toSet(), feedList: _feedList);
  }
}

class Podcast with ChangeNotifier {
  final BuildContext context;
  Podcast(this.context) {
    generateViewModels(); // calling view model setup on startup
    setupListeners();
  }
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

  /// Generates all view models, by default. Should be called on start up
  Future<void> generateViewModels(
      [SelectedGeneration selectedGeneration = SelectedGeneration.all,
      bool notifyOnCompletion = true]) async {
    if (selectedGeneration == SelectedGeneration.all ||
        selectedGeneration == SelectedGeneration.explore) {
      _exploreViewModel == null
          ? _exploreViewModel = await podcastViewModelFactory(
              mockSrcs, SelectedGeneration.explore)
          : _exploreViewModel!.model = await podcastViewModelFactory(
              mockSrcs, SelectedGeneration.explore);
    }
    if (selectedGeneration == SelectedGeneration.all ||
        selectedGeneration == SelectedGeneration.subscriptions) {
      _subscriptionViewModel == null
          ? _subscriptionViewModel = await podcastViewModelFactory(
              context.read<DataBaseManager>().subscriptions)
          : _subscriptionViewModel!.model = await podcastViewModelFactory(
              context.read<DataBaseManager>().subscriptions);
    }
    if (_loading) _loading = false;
    if (notifyOnCompletion) notifyListeners();
  }

  bool get isLoading => _loading;

  void setLoading() {
    if (!_loading) {
      _loading = true;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }

  RssFeed? get feed => this.podcastViewModel != null
      ? this.podcastViewModel!.selectedFeed.rssFeed
      : null;
  void set feed(RssFeed? rssFeed) {
    if (this._exploreViewModel != null)
      this._exploreViewModel!.selectedFeed =
          this._exploreViewModel!.feedList.firstWhere((info) {
        return (info.rssFeed!.title == rssFeed!.title);
      }, orElse: () => this._exploreViewModel!.selectedFeed);
    notifyListeners();
  }

  void setFeedFromString(String src) {
    if (this._exploreViewModel != null)
      this._exploreViewModel!.selectedFeed = this
          ._exploreViewModel!
          .feedList
          .firstWhere((info) => info.link == src,
              orElse: () => this._exploreViewModel!.selectedFeed);
  }

  void setFeedFromTitle(String title) {
    if (this._exploreViewModel != null) {
      this._exploreViewModel!.selectedFeed = this
          ._exploreViewModel!
          .feedList
          .firstWhere(
              (info) =>
                  info.rssFeed!.title!.toUpperCase() == title.toUpperCase(),
              orElse: () => this._exploreViewModel!.selectedFeed);
      notifyListeners();
    }
  }
  // void parse() async {
  //   notifyListeners();
  //   final res = await http.get(Uri.parse(
  //       url)); // remember to parse the url string because they made the package worse?
  //   final strXml = res.body;
  //   _feed = RssFeed.parse(strXml);
  //   if (_loading) _loading = false;
  //   notifyListeners();
  // }

  PodcastInfo? get selectedItem => this.podcastViewModel != null
      ? this.podcastViewModel!.selectedItem
      : null;
  set selectedItem(PodcastInfo? value) {
    this._exploreViewModel!.selectedItem = value;
    this._subscriptionViewModel?.selectedItem = value;
    notifyListeners();
  }

  // Map<String, RssFeed?> get multiFeed => _multiFeed;
  // void multiParse() async {
  //   for (String uri in _source.srcLink) {
  //     final res = await http.get(Uri.parse(
  //         uri)); // remember to parse the url string because they made the package worse?
  //     final strXml = res.body;
  //     _multiFeed.addEntries({uri: RssFeed.parse(strXml)}.entries);
  //   }

  //   notifyListeners();
  // }

  // showExplore() {
  //   this._source = PodcastSource(srcLink: mockSrcs);
  //   this.url = this._mockUrl;
  //   this.parse();
  //   this.multiParse();
  // }

  // showSubscriptions() {
  //   this._source =
  //       PodcastSource(srcLink: context.read<DataBaseManager>().subscriptions);
  //   if (this._source.srcLink.isEmpty) return;
  //   this.url = this._source.srcLink.first;
  //   this.parse();
  //   this.multiParse();
  // }

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
    // List<PodcastInfo> cachedSubs = [];

    /* 
    stream version of podcast view model creation! 
    */
    // podcastViewModelStream(mockSrcs, SelectedGeneration.explore)
    //     .listen((event) {
    //   event != null
    //       ? this._exploreViewModel = event
    //       : print("Empty stream item");
    //   notifyListeners();
    // });
    // podcastViewModelStream(this.context.read<DataBaseManager>().subscriptions,
    //         SelectedGeneration.subscriptions)
    //     .listen((event) {
    //   event != null
    //       ? this._subscriptionViewModel = event
    //       : print("Empty stream item");
    //   notifyListeners();
    // });
    this.context.read<DataBaseManager>().addListener(() {
      // regenerate subscription view model on change to subscription list
      this.generateViewModels(SelectedGeneration.subscriptions, false);

      // version that attempts to append to view model, needs factory refactor
      // List<String> _subs = context.read<DataBaseManager>().subscriptions;
      // if (this._exploreViewModel != null)
      //   cachedSubs = _subs
      //       .map((sub) => this
      //           ._exploreViewModel!
      //           .feedList
      //           .where((podcastInfoFeed) => podcastInfoFeed.link == sub)
      //           .first)
      //       .toList();
      // if (this._subscriptionViewModel != null) {
      //   cachedSubs.forEach((podcastInfoFeed) {
      //     this
      //         ._subscriptionViewModel!
      //         .addFeed(podcastInfoFeed)
      //         .then((value) => notifyListeners());
      //   });
      // } else
      //   this.generateViewModels(SelectedGeneration.subscriptions);

      // more network intensive solution that simply runs all requests again

      // if (!(this._subscriptionViewModel!.urlList.length == _subs.length &&
      //     this._subscriptionViewModel!.urlList.contains(_subs.length))) {
      //   this.generateViewModels(
      //       SelectedGeneration.subscriptions,
      //       // notify listeners when subscription feed is selected as those
      //       // will be on screen under that circumstance
      //       context.read<StateTracker>().feedSelection ==
      //           FeedSelection.subscription);
      // }
    });
    // links to the State Tracker object
    // this.context.read<StateTracker>().addListener(() {
    //   // propogate listener update in response to the state
    //   notifyListeners();
    // });
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
