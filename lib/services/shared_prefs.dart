import 'package:shared_preferences/shared_preferences.dart';

/// outline of useful functions
class AbstractDBService {
  saveData() => null;
  getData() => null;
  validateData() => null;
}

/// An object for handling access of the small, temp storage
/// on devices
/// - NOTE: may also be used to mock up db stuff while
/// I'm making that elsewhere
/// - NOTE ALSO: this is a bad idea
/// and you should not copy this practice, I'm being *naughty*
class SharedPreferencesService {
  SharedPreferencesService() {
    createPrefReference();
  }
  late SharedPreferences prefs;
  List<String>? _subscriptions = [];

  createPrefReference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  getSubscriptions() async =>
      _subscriptions = this.prefs.getStringList('subscriptions');

  setSubscriptions(List<String> newSubscriptionList) async =>
      this.prefs.setStringList('subscriptions', newSubscriptionList);

  addSubscription(String subscriptionUri) async {
    await this.getSubscriptions(); // latest subscriptions
    if (this._subscriptions == null) _subscriptions = [];
    _subscriptions!.add(subscriptionUri);
    this.prefs.setStringList('subscriptions', _subscriptions!);
  }
}
