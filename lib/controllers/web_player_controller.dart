import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_podcast_app/controllers/generic_player_controller.dart';
import 'package:webfeed/domain/rss_item.dart';

class WebPlayerController extends GenericController {
  AudioPlayer _webController = AudioPlayer();

  double _position = 0.0;
  double _duration = 1.0;

  /// exposed the actual player wrapped by this functionality
  AudioPlayer get webController => _webController;

  @override
  bool get isInitialized => true; // just pass this value for now

  @override
  bool get isPlaying => _webController.state == PlayerState.PLAYING;

  @override
  play() => _webController.resume().then((value) => notifyListeners());

  @override
  pause() => _webController.pause().then((value) => notifyListeners());

  @override
  double get position => _position;

  @override
  double get duration => _duration;

  @override
  Future<void> adaptiveSeekFunction(double position) {
    return _webController.seek(Duration(milliseconds: position.toInt()));
  }

  @override
  get events => _webController.onPlayerStateChanged;

  @override
  set currentTrack(RssItem rssItem) {
    super.currentTrack = rssItem;
    String audioSrc = rssItem.enclosure!.url!;
    _webController.setUrl(audioSrc);
  }

  @override
  void setupListeners() {
    _webController.onPlayerStateChanged.listen((_) => notifyListeners());
    _webController.onAudioPositionChanged.listen((progressDuration) {
      this.position = progressDuration.inMilliseconds.toDouble();
      print("entered the position listener function!");
      notifyListeners();
    });
    _webController.onDurationChanged.listen((durationDuration) {
      this.duration = durationDuration.inMilliseconds.toDouble();
      notifyListeners();
    });
  }

  @override
  void setup() {
    _webController.onPlayerStateChanged.listen((_) => notifyListeners());
    _webController.onAudioPositionChanged.listen((progressDuration) {
      this.position = progressDuration.inMilliseconds.toDouble();
      print("entered the position listener function!");
      notifyListeners();
    });
    _webController.onDurationChanged.listen((durationDuration) {
      this.duration = durationDuration.inMilliseconds.toDouble();
      notifyListeners();
    });
  }
}
