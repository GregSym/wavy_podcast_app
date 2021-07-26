import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_play_button.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_title_info.dart';
import 'package:flutter_podcast_app/components/podcast_img.dart';

class MiniDetailRow extends StatelessWidget {
  const MiniDetailRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PodcastImage(),
        MiniTitleInfo(),
        MiniPlayButton(),
      ],
    );
  }
}
