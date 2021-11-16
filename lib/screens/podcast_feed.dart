import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_header/menu_header.dart';
import 'package:flutter_podcast_app/components/menu/menu_item.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_player.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/models/podcast_info.dart';
import 'package:provider/provider.dart';

class PodcastFeed extends StatelessWidget {
  const PodcastFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // handle nullables

    // TODO: add a fallback for null-safety here

    // main functionality
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Consumer<Podcast>(
        builder: (context, _podcast, _) => _podcast.feed == null
            ? CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MenuHeader(),
                  Expanded(
                    child: ListView(
                      children: _podcast.feed!.items!
                          .map((rssItem) => PodcastMenuItem(
                                podcastInfo: PodcastInfo(
                                    link: _podcast.url,
                                    rssFeed: _podcast.feed,
                                    rssItem: rssItem),
                              ))
                          .toList(),
                    ),
                  ),
                  _podcast.selectedItem == null ? Container() : MiniPlayer()
                ],
              ),
      )),
    ));
  }
}
