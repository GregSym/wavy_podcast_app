import 'dart:async';

import 'package:flutter_podcast_app/controllers/generic_player_controller.dart';
import 'package:flutter_podcast_app/models/audio_player_types.dart';
import 'package:just_audio/just_audio.dart';
import 'package:webfeed/domain/rss_item.dart';

class WebPlayerController extends GenericController {
  AudioPlayer _webController = AudioPlayer();

  double _position = 0.0;
  double _duration = 1.0;

  @override
  get podcastController => AudioPlayerTypes(audioPlayer: _webController);

  /// exposed the actual player wrapped by this functionality
  AudioPlayer get webController => _webController;

  @override
  bool get isInitialized => true; // just pass this value for now

  @override
  bool get isPlaying => _webController.playing;

  @override
  play() async =>
      await _webController.play().then((value) => notifyListeners());

  @override
  pause() async =>
      await _webController.pause().then((value) => notifyListeners());

  @override
  double get position => _webController.position.inMilliseconds.toDouble();

  @override
  double get duration => _webController.duration == null
      ? 1.0
      : _webController.duration!.inMilliseconds.toDouble();

  @override
  Future<void> adaptiveSeekFunction(double position) {
    return _webController.seek(Duration(milliseconds: position.toInt()));
  }

  @override
  get events => null;

  @override
  set currentTrack(RssItem rssItem) {
    super.currentTrack = rssItem;
    String audioSrc = rssItem.enclosure!.url!;
    _webController.setUrl(audioSrc);
  }

  @override
  void setupListeners() {
    // TODO: implement setupListeners
    super.setupListeners();

    _webController.positionStream.listen((position) {
      // print(position);
      notifyListeners();
    });
  }
}
