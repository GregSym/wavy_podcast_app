import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';

class FakePodcast extends Podcast {
  final BuildContext context;
  FakePodcast(this.context) : super(context);
}
