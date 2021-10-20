import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_detail_row.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_slider.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/colour_manipulation.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<Podcast>().selectedItem == null) return Container();
    return Container(
      color:
          ColourManipulation.darken(Theme.of(context).colorScheme.surface, 8),
      height: Reactivity.miniPlayerHeight(context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: MiniDetailRow(),
          ),
          MiniPodcastSlider(),
        ],
      ),
    );
  }
}
