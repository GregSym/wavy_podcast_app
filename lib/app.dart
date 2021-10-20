import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/screens/podcast_player.dart';
import 'package:flutter_podcast_app/screens/podcast_selection.dart';
import 'package:flutter_podcast_app/screens/podcast_sliver_feed.dart';

class MaterialAppEntrypoint extends StatelessWidget {
  const MaterialAppEntrypoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          // _theme.getTheme,
          // context.read<PrimaryColourSelection>().getTheme,
          ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => PodcastSliverFeed(),
        "/menu": (context) => PodcastMenuScreen(),
        "/podcast-player": (context) => PodcastPlayer(),
      },
    );
  }
}
