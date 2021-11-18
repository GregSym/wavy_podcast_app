import 'package:flutter/material.dart';

class MessageEmptySubscriptionFeed extends StatelessWidget {
  const MessageEmptySubscriptionFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText("""
        No subscriptions - go find some out in the gaping void 
        of infinity that is our 3 item long library
    """);
  }
}
