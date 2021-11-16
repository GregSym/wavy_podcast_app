import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_app_bar/menu_app_bar.dart';
import 'package:flutter_podcast_app/components/menu/menu_header/menu_header_sliver.dart';
import 'package:flutter_podcast_app/components/podcast_boxes/podcast_box_subs_sliver.dart';
import 'package:flutter_podcast_app/components/subscriptions/subscription_sliver_list.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class SubscriptionMenuSliver extends StatelessWidget {
  const SubscriptionMenuSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<Podcast>().feed == null)
      return Center(child: CircularProgressIndicator());
    print("rebuilt");
    return CustomScrollView(
      slivers: [
        MenuAppBarSliver(),
        // PodcastBoxSliver(),
        // MenuHeaderSliver(),
        SubscriptionListSliver(),
      ],
    );
  }
}
