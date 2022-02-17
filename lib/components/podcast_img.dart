import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:provider/provider.dart';

/// draws for a full page player by default
/// marking the fullpage flag false will cause it to
/// utilise custom height - this is 0.0 by default
/// therefore both arguments are required if either are
/// in use
class PodcastImage extends StatelessWidget {
  final bool fullPage;
  final double customHeight;
  const PodcastImage({
    Key? key,
    this.fullPage = true,
    this.customHeight = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _dimensions =
        fullPage ? Reactivity.fullpagePodcastPlayerImg(context) : customHeight;

    return Hero(
        tag: context.read<Podcast>().selectedItem == null
            ? 'title'
            : context.read<Podcast>().selectedItem!.rssItem!.title ?? "title",
        child: Container(
          height: _dimensions,
          width: _dimensions,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(24.0),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(FeedAnalysisFunctions.imageFromPodcastInfo(
                    context.read<Podcast>().selectedItem)),
              )),
        ));
  }
}
