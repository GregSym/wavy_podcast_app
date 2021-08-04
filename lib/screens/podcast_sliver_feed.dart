import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/feed_scaffold.dart';

class PodcastSliverFeed extends StatelessWidget {
  const PodcastSliverFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FeedScaffold(child: PodcastSliverFeed()),
    ));
  }
}
