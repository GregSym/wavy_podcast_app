import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/controls_row.dart';
import 'package:flutter_podcast_app/components/slider.dart';

class PodcastPlayer extends StatelessWidget {
  const PodcastPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network("src"),
            PodcastSlider(),
            PodcastControlsRow(),
          ],
        ),
      ),
    ));
  }
}
