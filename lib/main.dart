import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/app.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/services/color_service.dart';
import 'package:flutter_podcast_app/services/database_manager.dart';
import 'package:provider/provider.dart';

void main() {
  // Beamer.setPathUrlStrategy();  // has some issues in deployment
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  runApp(MyApp());
}

/// Sets up the state-management before handing off to top level animator
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // manage the database connections
        ChangeNotifierProvider(create: (context) => DataBaseManager()),
        // track selected feeds and items
        ChangeNotifierProvider(
          create: (context) => Podcast(context)
            ..parse()
            ..multiParse(),
        ),
        // provide the media player across multiple screens in the app
        ChangeNotifierProvider(
          create: (context) => PodcastPlayerController()
            ..setupListeners()
            ..setContext(context),
        ),
        // app theme controller
        ChangeNotifierProvider(
            create: (context) => PrimaryColourSelection(context: context)),
      ],
      child: AnimatedAppThemeWrapper(),
    );
  }
}
