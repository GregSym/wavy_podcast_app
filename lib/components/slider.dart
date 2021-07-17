import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_player_controller.dart';
import 'package:provider/provider.dart';

class PodcastSlider extends StatelessWidget {
  const PodcastSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isInTransition = false;
    double _directValue = 0.0;
    return Consumer<PodcastPlayerController>(
        builder: (context, _podcastPlayerController, _) =>
            _podcastPlayerController.isInitialized
                ? Slider(
                    activeColor: Colors.red,
                    value: (_isInTransition)
                        ? _directValue
                        : _podcastPlayerController.position,
                    max: _podcastPlayerController.duration,
                    onChanged: (value) {
                      _isInTransition = true;
                      _directValue = value;
                      _podcastPlayerController
                          .seekTo(value)
                          .then((value) => _isInTransition = false);
                    })
                : CircularProgressIndicator());
  }
}
