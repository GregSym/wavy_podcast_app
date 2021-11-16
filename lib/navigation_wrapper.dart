import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/subscriptions/subscription_sliver_assembly.dart';
import 'package:flutter_podcast_app/components/subscriptions/subscription_sliver_list.dart';
import 'package:flutter_podcast_app/screens/podcast_player.dart';
import 'package:flutter_podcast_app/screens/podcast_selection.dart';
import 'package:flutter_podcast_app/screens/podcast_sliver_feed.dart';
import 'package:flutter_podcast_app/screens/settings_screen.dart';
import 'package:flutter_podcast_app/screens/subscription_screen.dart';

/// Maps routes to screens
class NavigationWrapper {
  static final routerDelegate = BeamerDelegate(
      locationBuilder: SimpleLocationBuilder(
        routes: {
          "/": (context, state) => const PodcastSliverFeed(),
          "/menu": (context, state) => const PodcastMenuScreen(),
          "/subscriptions": (context, state) => const SubscriptionSliverFeed(),
          "/podcast-player": (context, state) => const PodcastPlayer(),
          "/settings": (context, state) => const SettingsScreen(),
        },
      ),
      notFoundPage: BeamPage(child: const PodcastSliverFeed()));
}
