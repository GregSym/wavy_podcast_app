import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/mini_player/mini_player.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class FeedScaffold extends StatelessWidget {
  final Widget child;
  const FeedScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);

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
                  Expanded(
                    child: child,
                  ),
                  _podcast.selectedItem == null ? Container() : MiniPlayer(),
                ],
              ),
      )),
    ));
  }
}
