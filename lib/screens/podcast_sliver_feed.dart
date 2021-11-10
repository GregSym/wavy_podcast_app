import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/sliver_assembly/menu_customscrollview.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/body_with_player.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/expand_with_bottom_widget.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/side_menu_attachment.dart';
import 'package:flutter_podcast_app/components/tab_menu/tab_menu.dart';

/// Current default home screen
/// * wraps a podcast feed in the various reactive elements that handle menu
/// item layout for different screen size
class PodcastSliverFeed extends StatelessWidget {
  const PodcastSliverFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandWithBottomWidget(
        child: BodyWithPlayer(
          child: SideMenuAttachment(child: PodcastMenuSliver()),
        ),
        bottomWidget: TabMenuOptions(),
      ),
    );
  }
}
