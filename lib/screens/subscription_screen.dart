import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/body_with_player.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/expand_with_bottom_widget.dart';
import 'package:flutter_podcast_app/components/screen_scaffold/side_menu_attachment.dart';
import 'package:flutter_podcast_app/components/subscriptions/subscription_sliver_assembly.dart';
import 'package:flutter_podcast_app/components/tab_menu/tab_menu.dart';

class SubscriptionSliverFeed extends StatelessWidget {
  const SubscriptionSliverFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandWithBottomWidget(
        child: BodyWithPlayer(
          child: SideMenuAttachment(child: SubscriptionMenuSliver()),
        ),
        bottomWidget: TabMenuOptions(),
      ),
    );
  }
}
