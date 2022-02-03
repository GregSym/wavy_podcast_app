import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/podcast_boxes/podcast_box.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:provider/provider.dart';

class PodcastBoxSubsRow extends StatelessWidget {
  const PodcastBoxSubsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<Podcast>().podcastViewModel!.feedList.isEmpty ||
        context
            .read<Podcast>()
            .podcastViewModel!
            .feedList
            .any((element) => element == null)) return Container();
    return Container(
      height: Reactivity.menuItemHeight(context) * 1.3,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: context
            .read<Podcast>()
            .podcastViewModel!
            .feedList
            .map((podcastInfoFeed) => PodcastBox(
                rssFeed: {podcastInfoFeed.link!: podcastInfoFeed.rssFeed}
                    .entries
                    .first))
            .toList(),
      ),
    );
  }
}
