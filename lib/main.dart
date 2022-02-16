import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/app.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/services/color_service.dart';
import 'package:flutter_podcast_app/services/database_manager.dart';
import 'package:flutter_podcast_app/services/state_trackers.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Beamer.setPathUrlStrategy();  // has some issues in deployment
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MyApp(
    prefs: prefs,
  ));
}

/// Sets up the state-management before handing off to top level animator
class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({Key? key, required this.prefs}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // some miscellaneous state-trackes, should move these
        ChangeNotifierProvider(create: (context) => StateTracker()),
        // manage the database connections
        ChangeNotifierProvider(
            create: (context) => DataBaseManager(prefs: prefs)),
        // track selected feeds and items
        ChangeNotifierProvider(create: (context) => Podcast(context)
            // ..parse()
            // ..multiParse(),
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
