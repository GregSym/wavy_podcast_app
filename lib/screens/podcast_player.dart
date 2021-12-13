import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/controls_row.dart';
import 'package:flutter_podcast_app/components/podcast_img.dart';
import 'package:flutter_podcast_app/components/podcast_title_info.dart';
import 'package:flutter_podcast_app/components/slider.dart';
import 'package:flutter_podcast_app/components/timestamp_components.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class PodcastPlayer extends StatelessWidget {
  const PodcastPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<Podcast>().podcastViewModel == null) {
      Navigator.pushNamed(context, '/');
      return Text("No Podcast Episode Selected");
    }
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PodcastImage(),
            PodcastTitelInfo(),
            PodcastTimestamp(),
            PodcastSlider(),
            PodcastControlsRow(),
          ],
        ),
      ),
    ));
  }
}
