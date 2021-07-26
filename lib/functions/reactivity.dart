import 'package:flutter/material.dart';

/// reactive component size constants that draw on the screen size
class Reactivity {
  /// total screen height - wrapper for MediaQuery call
  /// - why? I don't like writing it out, too many dots
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// total height of the mini player component
  static double miniPlayerHeight(BuildContext context) =>
      Reactivity.height(context) / 10;

  /// height of the details section of the mini player
  /// - the larger section with the img, title and play/pause button
  static double miniDetailsHeight(BuildContext context) =>
      Reactivity.miniPlayerHeight(context) * .8;

  /// height of the slider in the mini player
  static double miniSliderHeight(BuildContext context) =>
      Reactivity.miniPlayerHeight(context) -
      Reactivity.miniDetailsHeight(context);
}
