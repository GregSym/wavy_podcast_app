import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/controls_row.dart';
import 'package:flutter_podcast_app/components/slider.dart';
import 'package:flutter_podcast_app/components/timestamp_components.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class PodcastPlayer extends StatelessWidget {
  const PodcastPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network(
                context.read<Podcast>().feed!.image!.url!), //TODO: handle null
            PodcastTimestamp(),
            PodcastSlider(),
            PodcastControlsRow(),
          ],
        ),
      ),
    ));
  }
}
