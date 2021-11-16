import 'package:flutter/foundation.dart';

enum FeedSelection { explore, subscription }

class StateTracker with ChangeNotifier {
  FeedSelection _feedSelection = FeedSelection.explore;

  FeedSelection get feedSelection => _feedSelection;
  set feedSelection(FeedSelection feedSelection) {
    _feedSelection = feedSelection;
    notifyListeners();
  }
}
