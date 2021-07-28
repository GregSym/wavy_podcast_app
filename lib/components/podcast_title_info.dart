import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/null_checks.dart';
import 'package:provider/provider.dart';

class PodcastTitelInfo extends StatelessWidget {
  const PodcastTitelInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Podcast>(
        builder: (context, _podcast, _) => Text(
              NullChecks.checkRssItem(_podcast.selectedItem)
                  ? _podcast.selectedItem!.title ?? "Title"
                  : "Title",
            ));
  }
}
