import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/podcast_boxes/podcast_box_sub_row.dart';

class PodcastBoxSliver extends StatelessWidget {
  const PodcastBoxSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: PodcastBoxSubsRow(),
    );
  }
}
