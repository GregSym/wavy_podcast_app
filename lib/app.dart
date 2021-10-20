import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/screens/podcast_player.dart';
import 'package:flutter_podcast_app/screens/podcast_selection.dart';
import 'package:flutter_podcast_app/screens/podcast_sliver_feed.dart';
import 'package:flutter_podcast_app/services/color_service.dart';
import 'package:provider/provider.dart';

class MaterialAppEntrypoint extends StatelessWidget {
  const MaterialAppEntrypoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: context.read<PrimaryColourSelection>(),
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme:
                // _theme.getTheme,
                context.read<PrimaryColourSelection>().getTheme,
            darkTheme: context.read<PrimaryColourSelection>().getDarkTheme,
            themeMode: ThemeMode.dark,
            //     ThemeData(
            //   primarySwatch: Colors.blue,
            // ),
            routes: {
              "/": (context) => PodcastSliverFeed(),
              "/menu": (context) => PodcastMenuScreen(),
              "/podcast-player": (context) => PodcastPlayer(),
            },
          );
        });
  }
}
