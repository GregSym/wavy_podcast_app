import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/sliver_assembly/menu_customscrollview.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/body_with_player.dart';

class PodcastSliverFeed extends StatelessWidget {
  const PodcastSliverFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BodyWithPlayer(
        child: PodcastMenuSliver(),
      ),
    ));
  }
}
