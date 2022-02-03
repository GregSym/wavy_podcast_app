import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/feed_options/feed_menu_items.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class PodcastMenuScreen extends StatelessWidget {
  const PodcastMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<Podcast>(
            builder: (context, _podcast, _) =>
                _podcast.podcastViewModel == null ||
                        _podcast.podcastViewModel!.feedList == 0
                    ? CircularProgressIndicator()
                    : ListView(
                        children: _podcast.podcastViewModel!.feedList
                            .map((podcastInfoFeed) => FeedMenuItem(
                                link: podcastInfoFeed.link!,
                                rssFeed: podcastInfoFeed.rssFeed!))
                            .toList(),
                      )),
      ),
    );
  }
}
