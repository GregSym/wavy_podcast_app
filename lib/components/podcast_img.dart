import 'package:flutter/cupertino.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:provider/provider.dart';

class PodcastImage extends StatelessWidget {
  const PodcastImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: context.read<Podcast>().selectedItem!.title ?? "title",
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(FeedAnalysisFunctions.imageFromPodcastInfo(
                    PodcastInfo(
                        rssFeed: context.read<Podcast>().feed,
                        rssItem: context.read<Podcast>().selectedItem))),
              )),
        ));
  }
}
