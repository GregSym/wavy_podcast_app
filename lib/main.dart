import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/screens/podcast_feed.dart';
import 'package:flutter_podcast_app/screens/podcast_player.dart';
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
          create: (context) => PodcastPlayerController()
            ..setupListeners()
            ..setContext(context),
        ),
        ChangeNotifierProvider(
          create: (context) => Podcast()..parse(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => PodcastFeed(),
          "/podcast-player": (context) => PodcastPlayer(),
        },
      ),
    );
  }
}
