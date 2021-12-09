import 'package:flutter/foundation.dart';

/// enum repr of different display feed options available
enum FeedSelection { explore, subscription }

/// miscellaneous state tracker tool for sundry state objects
class StateTracker with ChangeNotifier {
  FeedSelection _feedSelection = FeedSelection.explore;

  /// tracker enum for the selected feed to display on the frontend client
  FeedSelection get feedSelection => _feedSelection;
  set feedSelection(FeedSelection feedSelection) {
    _feedSelection = feedSelection;
    notifyListeners();
  }
}
