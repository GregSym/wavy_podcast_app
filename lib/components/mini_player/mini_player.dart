import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_detail_row.dart';
import 'package:flutter_podcast_app/components/slider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      child: Column(
        children: [
          MiniDetailRow(),
          PodcastSlider(),
        ],
      ),
    );
  }
}
