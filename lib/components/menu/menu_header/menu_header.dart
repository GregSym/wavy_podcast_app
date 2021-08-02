import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_header/features_row.dart';
import 'package:flutter_podcast_app/components/menu/menu_header/top_row_info.dart';
import 'package:flutter_podcast_app/components/podcast_description.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          MenuHeaderTopRow(),
          MenuHeaderFeaturesRow(),
          PodcastDescription(),
        ],
      ),
    );
  }
}
