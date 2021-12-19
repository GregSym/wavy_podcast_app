import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_app_bar/menu_app_bar.dart';
import 'package:flutter_podcast_app/components/menu/menu_header/menu_header_sliver.dart';
import 'package:flutter_podcast_app/components/menu/menu_sliver_list.dart';
import 'package:flutter_podcast_app/components/podcast_boxes/podcast_box_subs_sliver.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';

class PodcastMenuSliver extends StatelessWidget {
  const PodcastMenuSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(context.watch<Podcast>().podcastViewModel);
    if (context.watch<Podcast>().podcastViewModel == null)
      return Center(child: CircularProgressIndicator());
    print("rebuilt");
    return RefreshIndicator(
      onRefresh: () => context.read<Podcast>().generateViewModels(),
      child: CustomScrollView(
        slivers: [
          MenuAppBarSliver(),
          PodcastBoxSliver(),
          MenuHeaderSliver(),
          MenuListSliver(),
        ],
      ),
    );
  }
}
