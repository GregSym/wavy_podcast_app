import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class PodcastDescription extends StatelessWidget {
  const PodcastDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      context.read<Podcast>().feed!.description ?? 'description',
      // softWrap: true,
      scrollPhysics: const ClampingScrollPhysics(),
    );
  }
}
