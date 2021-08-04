import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';

class MenuAppBarSliver extends StatelessWidget {
  const MenuAppBarSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: Reactivity.menuItemHeight(context) * 2,
      flexibleSpace: Center(
        child: Text(
          "Wavy Podcasts",
          style: TextStyle(
            fontSize: Reactivity.height(context) / 8,
          ),
        ),
      ),
    );
  }
}
