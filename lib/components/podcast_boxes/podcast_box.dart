import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:flutter_podcast_app/functions/transitions.dart';
import 'package:webfeed/domain/rss_feed.dart';

class PodcastBox extends StatelessWidget {
  final MapEntry<String, RssFeed?> rssFeed;
  const PodcastBox({
    Key? key,
    required this.rssFeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Transitions.transitionToFeed(context, rssFeed.key),
      child: PodcastBoxContents(rssFeed: rssFeed.value!),
    );
  }
}

class PodcastBoxContents extends StatelessWidget {
  const PodcastBoxContents({
    Key? key,
    required this.rssFeed,
  }) : super(key: key);

  final RssFeed rssFeed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      width: Reactivity.menuItemHeight(context),
      height: Reactivity.menuItemHeight(context),
      child: Center(
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  FeedAnalysisFunctions.imageFromFeed(rssFeed),
                  fit: BoxFit.fitHeight,
                )),
            Text(
              rssFeed.title ?? "Title",
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
