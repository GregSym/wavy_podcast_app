import 'package:beamer/beamer.dart';
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
      Beamer.of(context).beamToNamed('/');
      return const Text("No Podcast Episode Selected");
    }
    if (context.read<Podcast>().podcastViewModel?.selectedItem == null) {
      Beamer.of(context).beamToNamed('/');
      return const Text("No Podcast Episode Selected");
    }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              PodcastImage(),
              PodcastTitelInfo(),
              PodcastTimestamp(),
              PodcastSlider(),
              PodcastControlsRow(),
            ],
          ),
        ),
      ),
    ));
  }
}
