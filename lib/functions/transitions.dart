import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/rss_item.dart';

class Transitions {
  /// transition to feed from list of feed based items
  static void transitionToFeed(BuildContext context, String link,
      [bool withNavigation = false]) {
    var podRef = context.read<Podcast>();
    podRef.setLoading();
    podRef.url = link;
    context.read<Podcast>().parse();
    if (withNavigation) Beamer.of(context).beamToNamed('/');
  }

  /// transition to player from list of RssItem based widgets
  static void transitionToPlayer(BuildContext context, RssItem rssItem) {
    context.read<Podcast>().selectedItem =
        PodcastInfo(rssFeed: context.read<Podcast>().feed, rssItem: rssItem);
    context.read<PodcastPlayerController>().currentFeed = context
        .read<Podcast>()
        .feed; // TODO: fix this so it's order-of-operations ambivalent
    context.read<PodcastPlayerController>().currentTrack = rssItem;
    context.read<PodcastPlayerController>().play();
    Beamer.of(context).beamToNamed('/podcast-player');
  }

  static void transitionToPlayerFromMini(BuildContext context) =>
      Beamer.of(context).beamToNamed('/podcast-player');

  static void transitionToSettings(BuildContext context) =>
      Beamer.of(context).beamToNamed('/settings');
}
