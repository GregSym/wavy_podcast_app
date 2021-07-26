import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/constants/images_resources.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/rss_item.dart';

class PodcastBoxImg extends StatelessWidget {
  const PodcastBoxImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RssItem? rssItem = context.watch<Podcast>().selectedItem;
    if (rssItem == null) return Container();
    return FeedAnalysisFunctions.hasIndividualEpisodeImage(rssItem)
        ? Image.network(rssItem.itunes!.image!.href!)
        : Image.network(context.read<Podcast>().feed!.image!.url ??
            ImgResources.fallbackImgUri);
  }
}
