import 'package:flutter/material.dart';

class PodcastSlider extends StatelessWidget {
  const PodcastSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(value: 2, onChanged: null);
  }
}
