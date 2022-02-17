import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/sliver_assembly/menu_customscrollview.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/body_with_player.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/expand_with_bottom_widget.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/side_menu_attachment.dart';
import 'package:flutter_podcast_app/components/subscriptions/subscription_sliver_assembly.dart';
import 'package:flutter_podcast_app/components/tab_menu/tab_menu.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/network_operations.dart';
import 'package:flutter_podcast_app/services/state_trackers.dart';
import 'package:provider/provider.dart';

/// Current default home screen
/// * wraps a podcast feed in the various reactive elements that handle menu
/// item layout for different screen size
class PodcastSliverFeed extends StatelessWidget {
  final String rssSrc;
  final String title;
  const PodcastSliverFeed({Key? key, this.rssSrc = "", this.title = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (title != "") {
      String _title = title.replaceAll(RegExp(r'_'), " ");
      print('received coms from path parameters!');
      print(_title);
      context.watch<Podcast>().setFeedFromTitle(_title);
    }
    if (rssSrc != "") {
      print('received coms from path parameters!');
      print(rssSrc);
      context.watch<Podcast>().setFeedFromString(rssSrc);
    }

    return Scaffold(
      body: ExpandWithBottomWidget(
        child: BodyWithPlayer(
          child: SideMenuAttachment(
              child: context.watch<StateTracker>().feedSelection ==
                      FeedSelection.explore
                  ? const PodcastMenuSliver()
                  : const SubscriptionMenuSliver()),
        ),
        bottomWidget: const TabMenuOptions(),
      ),
    );
  }
}
