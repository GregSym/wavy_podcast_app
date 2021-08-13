import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/podcast_boxes/podcast_box.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:provider/provider.dart';

class PodcastBoxSubsRow extends StatelessWidget {
  const PodcastBoxSubsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<Podcast>().multiFeed.isEmpty ||
        context
            .read<Podcast>()
            .multiFeed
            .values
            .any((element) => element == null)) return Container();
    return Container(
      height: Reactivity.menuItemHeight(context) * 1.2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: context
            .read<Podcast>()
            .multiFeed
            .entries
            .map((feed) => PodcastBox(rssFeed: feed))
            .toList(),
      ),
    );
  }
}
