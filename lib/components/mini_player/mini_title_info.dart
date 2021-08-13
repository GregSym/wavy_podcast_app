import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/null_checks.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:provider/provider.dart';

class MiniTitleInfo extends StatelessWidget {
  const MiniTitleInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Podcast>(
        builder: (context, _podcast, _) => Container(
              width: Reactivity.width(context) / 2,
              child: Text(
                NullChecks.checkRssItem(_podcast.selectedItem!.rssItem)
                    ? _podcast.selectedItem!.rssItem!.title ?? "Title"
                    : "Title",
              ),
            ));
  }
}
