import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/rss_item.dart';

class PodcastMenuItem extends StatelessWidget {
  final RssItem rssItem;
  const PodcastMenuItem({Key? key, required this.rssItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _fallbackImage = "";
    return ListTile(
      leading: FeedAnalysisFunctions.hasIndividualEpisodeImage(rssItem)
          ? Image.network(rssItem.itunes!.image!.href!)
          : Image.network(
              context.read<Podcast>().feed!.image!.url ?? _fallbackImage),
      title: Text(rssItem.title ?? "Missing title info"),
      subtitle: Text(rssItem.author ?? "Missing publishing info"),
      trailing: Icon(Icons.play_arrow_rounded),
      onTap: () => _handlePodcastSelection(context),
    );
  }

  _handlePodcastSelection(BuildContext context) {
    context.read<Podcast>().selectedItem = rssItem;
    context.read<PodcastPlayerController>().currentTrack = rssItem;
    Navigator.of(context).pushNamed("/podcast-player");
  }
}
