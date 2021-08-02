import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:provider/provider.dart';

class MiniPodcastImg extends StatelessWidget {
  const MiniPodcastImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: context.read<Podcast>().selectedItem!.rssItem!.title ?? "title",
        child: Container(
          height: MediaQuery.of(context).size.height / 11,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: NetworkImage(FeedAnalysisFunctions.imageFromPodcastInfo(
                context.read<Podcast>().selectedItem!)),
          )),
        ));
  }
}
