import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/podcast_box_img.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';

class MiniBoxImg extends StatelessWidget {
  const MiniBoxImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Reactivity.miniDetailsHeight(context),
      child: PodcastBoxImg(),
    );
  }
}
