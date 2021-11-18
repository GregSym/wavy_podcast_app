import 'package:flutter/foundation.dart';
import 'package:flutter_podcast_app/services/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages all the various db services this will probably have eventually
class DataBaseManager with ChangeNotifier {
  final SharedPreferences prefs;
  late SharedPreferencesService sharedPreferencesService;

  List<DataBaseService> dataBaseServices = [];

  DataBaseManager({required this.prefs}) {
    // dataBaseServices.add(sharedPreferencesService);
    // for (DataBaseService dataBaseService in dataBaseServices) {
    //   dataBaseService.addListener(() {
    //     notifyListeners();
    //   });
    // }
    sharedPreferencesService = SharedPreferencesService(prefs: prefs);
    this.getSubscriptions();
    ;
  }

  Future<void> createSharedPreferencesServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sharedPreferencesService = SharedPreferencesService(prefs: prefs);
  }

  List<String> get subscriptions => this.sharedPreferencesService.subscriptions;

  /// updates subscriptions
  getSubscriptions() async => this
      .sharedPreferencesService
      .getSubscriptions()
      .then((value) => notifyListeners());

  /// sets subscription storage to a new list
  setSubscriptions(List<String> newSubscriptionList) async => this
      .sharedPreferencesService
      .setSubscriptions(newSubscriptionList)
      .then((value) => notifyListeners());

  /// adds a single subscription to the old list
  addSubscription(String subscriptionUri) async => this
      .sharedPreferencesService
      .addSubscription(subscriptionUri)
      .then((value) => notifyListeners());

  removeSubscription(String subscriptionUri) async => this
      .sharedPreferencesService
      .removeSubscription(subscriptionUri)
      .then((value) => notifyListeners());
}
