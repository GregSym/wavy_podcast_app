import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/slider.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:flutter_podcast_app/style/slider_custom_track_shape.dart';

class MiniPodcastSlider extends StatelessWidget {
  const MiniPodcastSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Reactivity.miniSliderHeight(context),
      child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2.0,
            trackShape: CustomTrackShape(), // makes it wider than default
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 2.0,
              disabledThumbRadius: 2.0,
              elevation: 0.0,
            ),
          ),
          child: const PodcastSlider()),
    );
  }
}
