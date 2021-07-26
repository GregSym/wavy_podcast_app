import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_detail_row.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_slider.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Reactivity.miniPlayerHeight(context),
      child: Column(
        children: [
          MiniDetailRow(),
          MiniPodcastSlider(),
        ],
      ),
    );
  }
}
