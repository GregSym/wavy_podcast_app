import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/slider.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';

class MiniPodcastSlider extends StatelessWidget {
  const MiniPodcastSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Reactivity.miniSliderHeight(context),
      child: PodcastSlider(),
    );
  }
}
