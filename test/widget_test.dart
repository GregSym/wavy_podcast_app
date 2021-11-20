// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/services/shared_prefs.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_podcast_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group(
      "DB Tests",
      () => test("Test local small storage", () async {
            SharedPreferences.setMockInitialValues({});
            List<String> testList = [
              "a string for testing \'subscriptions\' key"
            ];

            String testSingleSubscription =
                "a single string for testing subscriptions";

            /// subscriptions
            String testKey = "subscriptions";
            var prefs = await SharedPreferences.getInstance();
            final sharedPreferencesService =
                SharedPreferencesService(prefs: prefs);

            // get subscriptions up front
            sharedPreferencesService.getSubscriptions();

            // test that it starts out empty
            expect(prefs.getStringList(testKey) == null,
                true); // underlying storage
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
              List<String> newTestList = [
                testList.first,
                testSingleSubscription
              ];
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
          }));

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(await MyApp(
      prefs: await SharedPreferences.getInstance(),
    ));

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.check), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsNothing);
    expect(find.byIcon(Icons.check), findsOneWidget);

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
