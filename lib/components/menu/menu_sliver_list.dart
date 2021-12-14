import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_item.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:provider/provider.dart';

class MenuListSliver extends StatelessWidget {
  const MenuListSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Podcast>(
        builder: (context, _podcast, _) =>
            _podcast.podcastViewModel == null || _podcast.isLoading
                ? SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()))
                : SliverList(
                    delegate: SliverChildListDelegate(_podcast.feed!.items!
                        .map((rssItem) => PodcastMenuItem(
                            podcastInfo: PodcastInfo(
                                link: _podcast.url,
                                rssFeed: _podcast.feed!,
                                rssItem: rssItem)))
                        .toList())));
  }
}
