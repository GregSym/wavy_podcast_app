import 'package:better_player/better_player.dart';
import 'package:just_audio/just_audio.dart';

/// A model that dynamically returns different player controllers
/// - essentially a workaround for the lack of dual classes in dart
/// - maybe I should be using a factory to implement this?
class AudioPlayerTypes {
  BetterPlayerController? betterPlayerController;
  AudioPlayer? audioPlayer;
  AudioPlayerTypes({this.betterPlayerController, this.audioPlayer});
}
