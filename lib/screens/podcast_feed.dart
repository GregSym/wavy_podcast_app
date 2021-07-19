import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_item.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class PodcastFeed extends StatelessWidget {
  const PodcastFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // handle nullables
    if (context.read<Podcast>().feed.items == null) {
      return Text("Unexpected RSS structure, no items present in feed");
    }
    // main functionality
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: ListView(
          children: context
              .read<Podcast>()
              .feed
              .items!
              .map((rssItem) => PodcastMenuItem(rssItem: rssItem))
              .toList(),
        ),
      ),
    ));
  }
}
