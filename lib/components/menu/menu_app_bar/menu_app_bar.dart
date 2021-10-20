import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/podcast_box_img.dart';
import 'package:flutter_podcast_app/components/user/user_bubble.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:flutter_podcast_app/services/color_service.dart';
import 'package:provider/provider.dart';

class MenuAppBarSliver extends StatelessWidget {
  const MenuAppBarSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PrimaryColourSelection>(
      builder: (context, _colourSelection, _) => SliverAppBar(
        // backgroundColor: _colourSelection.getTheme.colorScheme.primary,
        // foregroundColor: _colourSelection.getTheme.colorScheme.onPrimary,
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
                // color: _colourSelection.getTheme.colorScheme.onPrimary,
              )),
        ),
      ),
    );
  }
}
