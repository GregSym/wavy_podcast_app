import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/functions/transitions.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/rss_item.dart';

class PodcastMenuItem extends StatelessWidget {
  final PodcastInfo podcastInfo;
  const PodcastMenuItem({Key? key, required this.podcastInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _fallbackImage = "";
    return ListTile(
      leading: Hero(
        tag: podcastInfo.rssItem!.title ?? "key",
        child: FeedAnalysisFunctions.hasIndividualEpisodeImage(
                podcastInfo.rssItem!)
            ? Image.network(podcastInfo.rssItem!.itunes!.image!.href!)
            : Image.network(podcastInfo.rssFeed!.image!.url ?? _fallbackImage),
      ),
      title: Text(podcastInfo.rssItem!.title ?? "Missing title info"),
      subtitle: Text(podcastInfo.rssItem!.author ?? "Missing publishing info"),
      trailing: Icon(Icons.play_arrow_rounded),
      onTap: () =>
          // _handlePodcastSelection(context)
          Transitions.transitionToPlayer(context, podcastInfo.rssItem!),
    );
  }
}
