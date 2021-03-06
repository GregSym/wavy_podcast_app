import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// outline of useful functions
class AbstractDBService {
  saveData() => null;
  getData() => null;
  validateData() => null;
}

/// One day this'll be the parent class of DBServices and it'll be more abstract
/// : as seen above in AbstractDBService
class DataBaseService with ChangeNotifier {
  // TODO: remove direct connection to subscriptions in code once this branches
  // out
  List<String> get subscriptions => [];

  /// updates subscriptions
  getSubscriptions() async => null;

  /// sets subscription storage to a new list
  setSubscriptions(List<String> newSubscriptionList) async => null;

  /// adds a single subscription to the old list
  addSubscription(String subscriptionUri) async => null;

  removeSubscription(String subscriptionUri) async => null;
}

/// An object for handling access of the small, temp storage
/// on devices
/// - NOTE: may also be used to mock up db stuff while
/// I'm making that elsewhere
/// - NOTE ALSO: this is a bad idea
/// and you should not copy this practice, I'm being *naughty*
class SharedPreferencesService extends DataBaseService {
  SharedPreferences prefs;
  SharedPreferencesService({required this.prefs}) : super() {
    createPrefReference();
    getSubscriptions();
    print('creating instance of shared preferences');
  }
  List<String>? _subscriptions = [];

  List<String> get subscriptions => this._subscriptions ?? [];

  Future<void> createPrefReference() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  /// updates subscriptions
  Future<void> getSubscriptions() async {
    try {
      _subscriptions = this.prefs.getStringList('subscriptions');
    } catch (e) {
      this.setSubscriptions(this._subscriptions ?? []);
    }
  }

  /// sets subscription storage to a new list
  Future<void> setSubscriptions(List<String> newSubscriptionList) async => this
      .prefs
      .setStringList('subscriptions', newSubscriptionList)
      .then((value) => this._subscriptions = newSubscriptionList.toList());

  /// adds a single subscription to the old list
  Future<void> addSubscription(String subscriptionUri) async {
    await this.getSubscriptions(); // latest subscriptions
    if (this._subscriptions == null) _subscriptions = [];
    if (!this._subscriptions!.contains(subscriptionUri))
      _subscriptions!.add(subscriptionUri);
    await this.prefs.setStringList('subscriptions', _subscriptions!);
  }

  Future<void> removeSubscription(String subscriptionUri) async {
    await this.getSubscriptions();
    if (this._subscriptions == null) {
      _subscriptions = [];
    }
    _subscriptions!.removeWhere((element) => element == subscriptionUri);
    await this.prefs.remove('subscriptions');
    await this.setSubscriptions(_subscriptions ?? []);
  }
}
