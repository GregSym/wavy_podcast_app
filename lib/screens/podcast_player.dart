import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/controls_row.dart';
import 'package:flutter_podcast_app/components/slider.dart';
import 'package:flutter_podcast_app/components/timestamp_components.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:provider/provider.dart';

class PodcastPlayer extends StatelessWidget {
  const PodcastPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<Podcast>().selectedItem == null) {
      return Text("No Podcast Episode Selected");
    }
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FeedAnalysisFunctions.hasIndividualEpisodeImage(
                    context.read<Podcast>().selectedItem!)
                ? Image.network(context
                    .read<Podcast>()
                    .selectedItem!
                    .itunes!
                    .image!
                    .href!) //TODO: handle null
                : Image.network(context.read<Podcast>().feed!.image!.url!),
            PodcastTimestamp(),
            PodcastSlider(),
            PodcastControlsRow(),
          ],
        ),
      ),
    ));
  }
}
