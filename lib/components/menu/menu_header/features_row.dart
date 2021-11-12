import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/services/database_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// features attached to the menu at the top of a feed
class MenuHeaderFeaturesRow extends StatelessWidget {
  const MenuHeaderFeaturesRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String feedUrl = context.read<Podcast>().url;
    return Row(
      children: [
        Consumer<DataBaseManager>(
            builder: (context, _dbManager, _) => IconButton(
                  onPressed: () => _dbManager.subscriptions.contains(feedUrl)
                      ? _dbManager.removeSubscription(feedUrl)
                      : _dbManager.addSubscription(feedUrl),
                  icon: Icon(_dbManager.subscriptions.contains(feedUrl)
                      ? Icons.check
                      : Icons.add),
                )),
        IconButton(
          onPressed: null,
          icon: Icon(Icons.circle),
        ),
        IconButton(
          onPressed: () async => (context.read<Podcast>().feed != null)
              ? await canLaunch(context.read<Podcast>().feed!.link!)
                  ? await launch(context.read<Podcast>().feed!.link!)
                  : null
              : null,
          icon: Icon(Icons.share),
        ),
      ],
    );
  }
}
