import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/components/menu/menu_header/menu_header.dart';

class MenuHeaderSliver extends StatelessWidget {
  const MenuHeaderSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: MenuHeader(),
    );
  }
}
