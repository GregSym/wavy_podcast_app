import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class Transitions {
  static void transitionToFeed(BuildContext context, String link) {
    var podRef = context.read<Podcast>();
    podRef.url = link;
    context.read<Podcast>().parse();
    Navigator.of(context).pushNamed('/');
  }
}
