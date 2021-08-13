import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';

import 'menu_item.dart';

class MenuPodcastList extends StatelessWidget {
  final RssFeed podcast;
  const MenuPodcastList({Key? key, required this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: podcast.items!
          .map((rssItem) => PodcastMenuItem(rssItem: rssItem))
          .toList(),
    );
  }
}
