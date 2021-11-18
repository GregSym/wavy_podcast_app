import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_item.dart';
import 'package:flutter_podcast_app/components/messages/empty_feed_messages.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:provider/provider.dart';

class SubscriptionListSliver extends StatelessWidget {
  const SubscriptionListSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Podcast>(
        builder: (context, _podcast, _) => FutureBuilder<List<PodcastInfo>>(
              future: _podcast.subscriptionFeed,
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData ||
                          _podcast.isLoading
                      ? SliverToBoxAdapter(
                          child: Center(
                              child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )))
                      : snapshot.data!.isEmpty
                          ? SliverToBoxAdapter(
                              child: Center(
                                  child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MessageEmptySubscriptionFeed(),
                            )))
                          : SliverList(
                              delegate: SliverChildListDelegate(snapshot.data!
                                  .map((podcastInfo) =>
                                      PodcastMenuItem(podcastInfo: podcastInfo))
                                  .toList())),
            ));
  }
}
