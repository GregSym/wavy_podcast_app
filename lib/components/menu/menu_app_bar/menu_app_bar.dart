import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/podcast_box_img.dart';
import 'package:flutter_podcast_app/components/user/user_bubble.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';

class MenuAppBarSliver extends StatelessWidget {
  const MenuAppBarSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: Reactivity.expandedAppBarHeight(context),
      // floating: true,
      actions: [
        UserBubble(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: PodcastBoxImg(
          fromFeed: true,
        ),
        title: Text("Wavy Podcasts",
            style: TextStyle(
              fontSize: Reactivity.expandedAppBarHeight(context) / 3,
            )),
      ),
    );
  }
}
