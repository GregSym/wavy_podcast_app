import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/rss_feed.dart';

class PodcastBoxImg extends StatelessWidget {
  final bool fromFeed;
  const PodcastBoxImg({Key? key, this.fromFeed = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (fromFeed) return const PodcastBoxImgFromFeed();
    PodcastInfo? podcastInfo = context.watch<Podcast>().selectedItem;
    if (podcastInfo == null) return Container();
    return Image.network(
      FeedAnalysisFunctions.imageFromPodcastInfo(podcastInfo),
      fit: BoxFit.cover,
    );
  }
}

class PodcastBoxImgFromFeed extends StatelessWidget {
  const PodcastBoxImgFromFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RssFeed? rssFeed = context.watch<Podcast>().feed;
    if (rssFeed == null) return Container();
    return Image.network(
      FeedAnalysisFunctions.imageFromFeed(rssFeed),
      fit: BoxFit.cover,
    );
  }
}
