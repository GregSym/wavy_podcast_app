import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/podcast_box_img.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:provider/provider.dart';

class MenuHeaderTopRow extends StatelessWidget {
  const MenuHeaderTopRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Podcast>(
        builder: (context, _podcast, _) => Container(
              height: Reactivity.headerImageHeight(context) + 8.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(_podcast.feed!.title ?? 'title'),
                      Text(_podcast.feed!.itunes!.author ?? 'author')
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: PodcastBoxImg(),
                  )
                ],
              ),
            ));
  }
}
