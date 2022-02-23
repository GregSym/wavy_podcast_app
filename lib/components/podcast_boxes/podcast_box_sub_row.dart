import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/podcast_boxes/podcast_box.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:provider/provider.dart';

class PodcastBoxSubsRow extends StatelessWidget {
  const PodcastBoxSubsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = ScrollController(initialScrollOffset: 0.0);
    var _localHeight = Reactivity.menuItemHeight(context) * 1.3;
    if (context.read<Podcast>().podcastViewModel!.feedList.isEmpty ||
        context
            .read<Podcast>()
            .podcastViewModel!
            .feedList
            .any((element) => element == null)) return Container();
    return SizedBox(
      height: _localHeight + 20,
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.bottom,
        controller: _controller,
        interactive: true,
        child: ListView(
          controller: _controller,
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
      ),
    );
  }
}
