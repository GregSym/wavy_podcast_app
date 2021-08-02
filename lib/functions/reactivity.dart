import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/functions/platform_analysis.dart';

/// reactive component size constants that draw on the screen size
/// - should probably move this to the constants folder
class Reactivity {
  /// total screen height - wrapper for MediaQuery call
  /// - why? I don't like writing it out, too many dots
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double fullpagePodcastPlayerImg(BuildContext context) =>
      Reactivity.height(context) / 3;

  /* 
  Mini player params----------------------------etc
  */
  /// minimum height of the mini player
  static double minimumMiniPlayerHeight = 60.0;

  /// total height of the mini player component
  static double miniPlayerHeight(BuildContext context) =>
      Reactivity.height(context) <= minimumMiniPlayerHeight
          ? Reactivity.height(context)
          : Reactivity.height(context) / 10 > minimumMiniPlayerHeight
              ? Reactivity.height(context) / 10
              : minimumMiniPlayerHeight;

  /// height of the details section of the mini player
  /// - the larger section with the img, title and play/pause button
  static double miniDetailsHeight(BuildContext context) =>
      Reactivity.miniPlayerHeight(context) * .8;

  /// height of the slider in the mini player
  static double miniSliderHeight(BuildContext context) =>
      Reactivity.miniPlayerHeight(context) -
      Reactivity.miniDetailsHeight(context);

  /* 
  feed params----------------------------etc
  */
  static double menuItemHeight(BuildContext context) =>
      // TODO: set out measurements rather than using platform id so
      // web page resizing works
      PlatformAnalysis.isMobile
          ? Reactivity.height(context) / 6 // mobile height
          : Reactivity.height(context) / 11; // web page height
}
