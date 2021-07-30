import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/constants/web_defaults.dart';
import 'package:flutter_podcast_app/controllers/podcast_stream.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/rss_feed.dart';

class FeedMenuItem extends StatelessWidget {
  final RssFeed rssFeed;
  final String link;
  const FeedMenuItem({Key? key, required this.rssFeed, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
          tag: rssFeed.title ?? "key",
          child: Image.network(
              rssFeed.itunes!.image!.href ?? rssFeed.image!.url ?? 'link')),
      title: Text(rssFeed.title ?? 'Podcast Name'),
      subtitle: Text(rssFeed.description ?? "description"),
      onTap: () => _feedSelectionHandler(context),
    );
  }

  _feedSelectionHandler(BuildContext context) {
    var podRef = context.read<Podcast>();
    podRef.url = link;
    context.read<Podcast>().parse();
    Navigator.of(context).pushNamed('/');
  }
}
