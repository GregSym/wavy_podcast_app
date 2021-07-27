import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_box_img.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_play_button.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_title_info.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';

class MiniDetailRow extends StatelessWidget {
  const MiniDetailRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO: come up with a real pagination plan at some point
      onTap: () => Navigator.of(context).pushNamed("/podcast-player"),
      child: Container(
        height: Reactivity.miniDetailsHeight(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MiniBoxImg(),
            MiniTitleInfo(),
            MiniPlayButton(),
          ],
        ),
      ),
    );
  }
}
