import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/null_checks.dart';
import 'package:flutter_podcast_app/screens/podcast_feed.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/rss_item.dart';

class MiniTitleInfo extends StatelessWidget {
  const MiniTitleInfo({Key? key}) : super(key: key);

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
