import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_item.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class MenuListSliver extends StatelessWidget {
  const MenuListSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Podcast>(
        builder: (context, _podcast, _) =>
            _podcast.feed == null || _podcast.isLoading
                ? SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()))
                : SliverList(
                    delegate: SliverChildListDelegate(_podcast.feed!.items!
                        .map((rssItem) => PodcastMenuItem(rssItem: rssItem))
                        .toList())));
  }
}

class SubscriptionListSliver extends StatelessWidget {
  const SubscriptionListSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Podcast>(
        builder: (context, _podcast, _) =>
            _podcast.feed == null || _podcast.isLoading
                ? SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()))
                : SliverList(
                    delegate: SliverChildListDelegate(_podcast.subscriptionFeed
                        .map((podcastInfo) =>
                            PodcastMenuItem(rssItem: podcastInfo.rssItem!))
                        .toList())));
  }
}
