import 'dart:html';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_podcast_app/controllers/generic_player_controller.dart';
import 'package:webfeed/domain/rss_item.dart';

class WebPlayerController extends GenericController {
  AudioPlayer _webController = AudioPlayer();

  /// exposed the actual player wrapped by this functionality
  AudioPlayer get webController => _webController;

  @override
  bool get isPlaying => _webController.state == PlayerState.PLAYING;

  @override
  play() => _webController.resume().then((value) => notifyListeners());

  @override
  pause() => _webController.pause().then((value) => notifyListeners());

  @override
  Future<void> adaptiveSeekFunction(double position) {
    // TODO: implement adaptiveSeekFunction
    return _webController.seek(Duration(milliseconds: position.toInt()));
  }

  @override
  // TODO: implement events
  get events => _webController.onPlayerStateChanged;

  @override
  set currentTrack(RssItem rssItem) {
    super.currentTrack = rssItem;
    String audioSrc = rssItem.enclosure!.url!;
    _webController.setUrl(audioSrc);
  }

  @override
  void setupListeners() {
    // TODO: implement setupListeners
    _webController.onPlayerStateChanged.listen((_) => notifyListeners());
  }
}
