import 'dart:async';

import 'package:flutter_podcast_app/constants/images_resources.dart';
import 'package:flutter_podcast_app/controllers/generic_player_controller.dart';
import 'package:flutter_podcast_app/functions/feed_analysis.dart';
import 'package:flutter_podcast_app/models/audio_player_types.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
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
  // TODO: implement buffered
  double get buffered =>
      _webController.bufferedPosition.inMilliseconds.toDouble();

  @override
  Future<void> adaptiveSeekFunction(double position) async {
    return await _webController.seek(Duration(milliseconds: position.toInt()));
  }

  @override
  get events => null;

  @override
  set currentTrack(RssItem rssItem) {
    super.currentTrack = rssItem;
    String audioSrc = rssItem.enclosure!.url!;
    // _webController.setUrl(audioSrc);
    _webController.setAudioSource(AudioSource.uri(Uri.parse(audioSrc),
        tag: MediaItem(
          id: audioSrc,
          title: rssItem.title ?? "No Title Given",
          album: this.currentFeed != null
              ? this.currentFeed!.title ?? "Podcast Name Not Found"
              : FeedAnalysisFunctions.authorFromItem(rssItem),
          artist: FeedAnalysisFunctions.authorFromItem(rssItem),
          artUri: Uri.parse(
              rssItem.itunes != null && rssItem.itunes!.image != null
                  ? rssItem.itunes!.image!.href ?? ImgResources.fallbackImgUri
                  : ImgResources.fallbackImgUri),
        )));
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
