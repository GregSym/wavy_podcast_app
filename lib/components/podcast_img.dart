import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:provider/provider.dart';

class PodcastImage extends StatelessWidget {
  const PodcastImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: context.read<Podcast>().selectedItem!.rssItem!.title ?? "title",
        child: Container(
          height: Reactivity.fullpagePodcastPlayerImg(context),
          width: Reactivity.fullpagePodcastPlayerImg(context),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(24.0),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(FeedAnalysisFunctions.imageFromPodcastInfo(
                    context.read<Podcast>().selectedItem!)),
              )),
        ));
  }
}
