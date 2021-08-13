import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';

class TabMenuOptions extends StatelessWidget {
  const TabMenuOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Reactivity.miniPlayerHeight(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }
}
