import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/functions/colour_manipulation.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class PrimaryColourSelection with ChangeNotifier {
  BuildContext context;
  late String _imgString;
  late ImageProvider _img;
  ThemeMode _themeMode = ThemeMode.system;
  final Map<String, Color> _cache = {};
  PrimaryColourSelection({required this.context}) {
    context.read<Podcast>().addListener(() async {
      await update();
    });
  }
  Color _dominantColor = Colors.blue;
  Future<void> update() async {
    setImg();
    await getImagePalette();
    notifyListeners();
  }

  void setImg() {
    if (context.read<Podcast>().podcastViewModel != null) {
      _imgString = FeedAnalysisFunctions.imageFromFeed(
          context.read<Podcast>().podcastViewModel!.selectedFeed.rssFeed);
    }
    _img = NetworkImage(_imgString);
  }

  /// Calculate dominant color from ImageProvider
  /// courtesy of Kym
  /// @ https://stackoverflow.com/questions/50449610/pick-main-color-from-picture
  Future<void> getImagePalette() async {
    if (_cache.containsKey(_imgString)) {
      _dominantColor = _cache[_imgString] ?? Colors.yellow;
      return;
    }
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(_img,
            size: const Size(300, 300));
    if (paletteGenerator.dominantColor != null) {
      _dominantColor = paletteGenerator.dominantColor!.color;
      _cache[_imgString] = _dominantColor;
    }
  }

  /// gets the default theme from the colour service
  ThemeData get getTheme => ThemeData(
      colorSchemeSeed: ColourManipulation.colorToMaterialColor(_dominantColor));

  /// gets a dark theme from the colour service class
  ThemeData get getDarkTheme =>
      // ThemeData.dark(); // basically does the same thing as turning down brightness
      ThemeData(
        colorSchemeSeed:
            ColourManipulation.colorToMaterialColor(_dominantColor),
        brightness: Brightness.dark,
      );

  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode newThemeMode) {
    _themeMode = newThemeMode;
    notifyListeners();
  }
}
