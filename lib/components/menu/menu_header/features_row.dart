import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:flutter_podcast_app/services/database_manager.dart';
import 'package:provider/provider.dart';

/// features attached to the menu at the top of a feed
class MenuHeaderFeaturesRow extends StatelessWidget {
  const MenuHeaderFeaturesRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String feedUrl = context.read<Podcast>().url;
    return Row(
      children: [
        IconButton(
          onPressed:
              context.watch<DataBaseManager>().subscriptions.contains(feedUrl)
                  ? context.read<DataBaseManager>().removeSubscription(feedUrl)
                  : context.read<DataBaseManager>().addSubscription(feedUrl),
          icon: Icon(
              context.watch<DataBaseManager>().subscriptions.contains(feedUrl)
                  ? Icons.check
                  : Icons.add),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(Icons.circle),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(Icons.share),
        ),
      ],
    );
  }
}
