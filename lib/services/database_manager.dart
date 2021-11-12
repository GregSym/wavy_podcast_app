import 'package:flutter/foundation.dart';
import 'package:flutter_podcast_app/services/shared_prefs.dart';

class DataBaseManager with ChangeNotifier {
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  List<DataBaseService> dataBaseServices = [];
  DataBaseManager() {
    dataBaseServices.add(sharedPreferencesService);
  }

  List<String> get subscriptions => this.sharedPreferencesService.subscriptions;

  /// updates subscriptions
  getSubscriptions() async => this.sharedPreferencesService.getSubscriptions();

  /// sets subscription storage to a new list
  setSubscriptions(List<String> newSubscriptionList) async =>
      this.sharedPreferencesService.setSubscriptions(newSubscriptionList);

  /// adds a single subscription to the old list
  addSubscription(String subscriptionUri) async =>
      this.sharedPreferencesService.addSubscription(subscriptionUri);

  removeSubscription(String subscriptionUri) async =>
      this.sharedPreferencesService.removeSubscription(subscriptionUri);
}
