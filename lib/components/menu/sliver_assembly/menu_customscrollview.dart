import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_header/menu_header_sliver.dart';
import 'package:flutter_podcast_app/components/menu/menu_sliver_list.dart';

class PodcastMenuSliver extends StatelessWidget {
  const PodcastMenuSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MenuHeaderSliver(),
        MenuListSliver(),
      ],
    );
  }
}
