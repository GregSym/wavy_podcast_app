import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_podcast_app/app.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/services/color_service.dart';
import 'package:provider/provider.dart';

void main() {
  // Beamer.setPathUrlStrategy();  // has some issues in deployment
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

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
          AnimatedAppThemeWrapper(),
      // ),
    );
  }
}
