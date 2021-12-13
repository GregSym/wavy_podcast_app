import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:flutter_podcast_app/screens/podcast_player.dart';
import 'package:provider/provider.dart';

import '../fakes/player_controller_fake.dart';
import '../fakes/podcast_fake.dart';

class FakePlayer extends StatelessWidget {
  const FakePlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FakePodcast(context)
            // ..parse()
            // ..multiParse(),
            ),
        ChangeNotifierProvider(
          create: (context) => FakeController()
            ..setupListeners()
            ..setContext(context),
        ),
      ],
      child: MaterialApp(
        home: TestingSetupPodcast(),
      ),
    );
  }
}

class TestingSetupPodcast extends StatelessWidget {
  const TestingSetupPodcast({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rssItem = context.read<Podcast>().feed!.items![0];
    context.read<Podcast>().selectedItem =
        PodcastInfo(rssFeed: context.read<Podcast>().feed, rssItem: rssItem);
    context.read<PodcastPlayerController>().currentFeed = context
        .read<Podcast>()
        .feed; // TODO: fix this so it's order-of-operations ambivalent
    context.read<PodcastPlayerController>().currentTrack = rssItem;
    context.read<PodcastPlayerController>().play();
    return PodcastPlayer();
  }
}
