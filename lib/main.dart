import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/screens/podcast_player.dart';
import 'package:flutter_podcast_app/screens/podcast_selection.dart';
import 'package:flutter_podcast_app/screens/podcast_sliver_feed.dart';
import 'package:flutter_podcast_app/services/color_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Podcast()
            ..parse()
            ..multiParse(),
        ),
        ChangeNotifierProvider(
          create: (context) => PodcastPlayerController()
            ..setupListeners()
            ..setContext(context),
        ),
        ChangeNotifierProvider(
            create: (context) => PrimaryColourSelection(context: context)),
      ],
      child:
          // Consumer<PrimaryColourSelection>(
          //   builder: (context, _theme, _) =>
          MaterialApp(
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
      ),
      // ),
    );
  }
}
