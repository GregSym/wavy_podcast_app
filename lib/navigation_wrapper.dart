import 'package:beamer/beamer.dart';
import 'package:flutter_podcast_app/screens/podcast_player.dart';
import 'package:flutter_podcast_app/screens/podcast_selection.dart';
import 'package:flutter_podcast_app/screens/podcast_sliver_feed.dart';

class NavigationWrapper {
  static final routerDelegate = BeamerDelegate(
    locationBuilder: SimpleLocationBuilder(
      routes: {
        "/": (context, state) => const PodcastSliverFeed(),
        "/menu": (context, state) => const PodcastMenuScreen(),
        "/podcast-player": (context, state) => const PodcastPlayer(),
      },
    ),
  );
}
