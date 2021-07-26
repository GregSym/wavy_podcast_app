import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:provider/provider.dart';

class MiniPodcastImg extends StatelessWidget {
  const MiniPodcastImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: context.read<Podcast>().selectedItem!.title ?? "title",
        child: Container(
          height: MediaQuery.of(context).size.height / 11,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: FeedAnalysisFunctions.hasIndividualEpisodeImage(
                    context.read<Podcast>().selectedItem!)
                ? NetworkImage(
                    context.read<Podcast>().selectedItem!.itunes!.image!.href!,
                  ) //TODO: handle null
                : NetworkImage(
                    context.read<Podcast>().feed!.image!.url!,
                  ),
          )),
        ));
  }
}
