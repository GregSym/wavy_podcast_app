import 'package:flutter/material.dart';

/// static class for colour manipulation, such as darkening and lightening
/// THANKS mr_mmmmore (answerer) and jazzbpn (asker) @ https://stackoverflow.com/questions/58360989/programmatically-lighten-or-darken-a-hex-color-in-dart
class ColourManipulation {
  /// Darken a color by [percent] amount (100 = black)
  static Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }

  /// Lighten a color by [percent] amount (100 = white)
  static Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round());
  }

  /// generates a materialcolor type from a given color type
  /// - found @
  /// https://medium.com/py-bits/turn-any-color-to-material-color-for-flutter-d8e8e037a837
  static MaterialColor colorToMaterialColor(Color color) {
    // create a swatch of luminences
    Map<int, Color> colorMap = {
      50: Color.fromRGBO(color.red, color.green, color.blue, .1),
      100: Color.fromRGBO(color.red, color.green, color.blue, .2),
      200: Color.fromRGBO(color.red, color.green, color.blue, .3),
      300: Color.fromRGBO(color.red, color.green, color.blue, .4),
      400: Color.fromRGBO(color.red, color.green, color.blue, .5),
      500: Color.fromRGBO(color.red, color.green, color.blue, .6),
      600: Color.fromRGBO(color.red, color.green, color.blue, .7),
      700: Color.fromRGBO(color.red, color.green, color.blue, .8),
      800: Color.fromRGBO(color.red, color.green, color.blue, .9),
      900: Color.fromRGBO(color.red, color.green, color.blue, 1),
    };
    // return custom materialcolor
    return MaterialColor(color.value, colorMap);
  }
}
