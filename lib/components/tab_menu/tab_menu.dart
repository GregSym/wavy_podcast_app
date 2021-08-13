import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/constants/std_sizes.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';

class TabMenuOptions extends StatelessWidget {
  const TabMenuOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Reactivity.width(context) > StandardSizes.phoneWidth)
      return Container();
    return Container(
      height: Reactivity.miniPlayerHeight(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: null, icon: Icon(Icons.house_rounded)),
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          IconButton(onPressed: null, icon: Icon(Icons.list_alt)),
        ],
      ),
    );
  }
}
