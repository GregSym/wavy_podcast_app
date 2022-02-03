import 'package:flutter_podcast_app/services/shared_prefs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void testSharedPrefs() {
  return test("Test local small storage", () async {
    SharedPreferences.setMockInitialValues({});
    List<String> testList = ["a string for testing \'subscriptions\' key"];

    String testSingleSubscription = "a single string for testing subscriptions";

    /// subscriptions
    String testKey = "subscriptions";
    var prefs = await SharedPreferences.getInstance();
    final sharedPreferencesService = SharedPreferencesService(prefs: prefs);

    // get subscriptions up front
    sharedPreferencesService.getSubscriptions();

    // test that it starts out empty
    expect(prefs.getStringList(testKey) == null, true); // underlying storage
    expect(sharedPreferencesService.subscriptions.isEmpty,
        true); // custom abstraction

    // give it test data to store
    sharedPreferencesService.setSubscriptions(testList).then((_) {
      var bottomLevelList = prefs.getStringList(testKey) ?? [];
      // test that it contains the test data
      expect(bottomLevelList, testList); // underlying storage
      expect(sharedPreferencesService.subscriptions,
          testList); // custom abstraction
    });

    // add test data to stroage
    sharedPreferencesService
        .addSubscription(testSingleSubscription)
        .then((value) {
      List<String> bottomLevelList = prefs.getStringList(testKey) ?? [];
      List<String> newTestList = [testList.first, testSingleSubscription];
      // test that it contains the test data
      expect(bottomLevelList, newTestList); // underlying storage
      expect(sharedPreferencesService.subscriptions,
          newTestList); // custom abstraction

      // remove test data
      sharedPreferencesService
          .removeSubscription(testSingleSubscription)
          .then((value) {
        var bottomLevelList = prefs.getStringList(testKey) ?? [];
        // test that it contains the test data
        expect(bottomLevelList, testList); // underlying storage
        expect(sharedPreferencesService.subscriptions,
            testList); // custom abstraction
      });
    });
  });
}
