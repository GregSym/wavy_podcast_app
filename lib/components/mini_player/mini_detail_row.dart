import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_box_img.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_play_button.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_title_info.dart';
import 'package:flutter_podcast_app/components/seek_button.dart';
import 'package:flutter_podcast_app/components/timestamp_components.dart';
import 'package:flutter_podcast_app/constants/std_sizes.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:flutter_podcast_app/functions/transitions.dart';

class MiniDetailRow extends StatelessWidget {
  const MiniDetailRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO: come up with a real pagination plan at some point
      onTap: () => Transitions.transitionToPlayerFromMini(context),
      child: Container(
        height: Reactivity.miniDetailsHeight(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MiniBoxImg(),
            HideForPhoneSize(child: PodcastTimestamp()),
            HideForPhoneSize(child: PodcastSeekButton(rewind: true)),
            MiniTitleInfo(),
            HideForPhoneSize(child: PodcastSeekButton()),
            MiniPlayButton(),
          ],
        ),
      ),
    );
  }
}

/// a simple wrapper to return container for phone sizes and layouts
class HideForPhoneSize extends StatelessWidget {
  final Widget child;
  const HideForPhoneSize({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (StandardSizes.phoneWidth < Reactivity.width(context))
        ? child
        : Container();
  }
}
