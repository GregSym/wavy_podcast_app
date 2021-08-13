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
  PrimaryColourSelection({required this.context}) {
    this.update();
    context.read<Podcast>().addListener(() {
      this.update();
    });
  }
  Color _dominantColor = Colors.blue;
  void update() {
    this.setImg();
    this.getImagePalette();
    notifyListeners();
  }

  void setImg() {
    _imgString =
        FeedAnalysisFunctions.imageFromFeed(context.read<Podcast>().feed);
    _img = NetworkImage(_imgString);
  }

  /// Calculate dominant color from ImageProvider
  /// courtesy of Kym
  /// @ https://stackoverflow.com/questions/50449610/pick-main-color-from-picture
  Future<void> getImagePalette() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(_img);
    if (paletteGenerator.dominantColor != null) {
      _dominantColor = paletteGenerator.dominantColor!.color;
    }
  }

  ThemeData get getTheme => ThemeData(
      primarySwatch: ColourManipulation.colorToMaterialColor(_dominantColor));
}
