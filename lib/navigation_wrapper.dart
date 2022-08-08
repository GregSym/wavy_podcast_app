import 'package:beamer/beamer.dart';
import 'package:flutter_podcast_app/screens/podcast_player.dart';
import 'package:flutter_podcast_app/screens/podcast_selection.dart';
import 'package:flutter_podcast_app/screens/podcast_sliver_feed.dart';
import 'package:flutter_podcast_app/screens/settings_screen.dart';
import 'package:flutter_podcast_app/screens/subscription_screen.dart';

/// Maps routes to screens
class NavigationWrapper {
  static final routerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          "/": (context, state, data) => const PodcastSliverFeed(),
          "/rssfeed/:src": (context, state, data) =>
              state.pathParameters.containsKey('src')
                  ? PodcastSliverFeed(
                      rssSrc: state.pathParameters['src']!,
                    )
                  : const PodcastSliverFeed(),
          "/title/:title": (context, state, data) =>
              state.pathParameters.containsKey('title')
                  ? PodcastSliverFeed(
                      title: state.pathParameters['title']!,
                    )
                  : const PodcastSliverFeed(),
          "/menu": (context, state, data) => const PodcastMenuScreen(),
          "/subscriptions": (context, state, data) =>
              const SubscriptionSliverFeed(),
          "/podcast-player": (context, state, data) => const PodcastPlayer(),
          "/settings": (context, state, data) => const SettingsScreen(),
        },
      ),
      notFoundPage: BeamPage(child: const PodcastSliverFeed()));
}
