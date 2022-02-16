import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/functions/transitions.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';

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
      subtitle: Text(podcastInfo.rssItem != null
          ? FeedAnalysisFunctions.authorFromItem(podcastInfo.rssItem!)
          : "Missing Publisher Info"),
      trailing: Icon(Icons.play_arrow_rounded),
      onTap: () =>
          // _handlePodcastSelection(context)
          Transitions.transitionToPlayer(context, podcastInfo.rssItem!),
    );
  }
}
