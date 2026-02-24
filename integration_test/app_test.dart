import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End App Test', () {
    testWidgets('5. Tap on the first restaurant and verify navigation to detail page', (tester) async {
      // Start app
      app.main();
      
      // Wait for the intro page to settle
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // In IntroPage, there's a button "Get Started" to navigate to the list
      final getStartedButton = find.text('Get Started');
      expect(getStartedButton, findsOneWidget);

      await tester.tap(getStartedButton);
      
      // Wait for navigation and API call to complete
      await tester.pumpAndSettle(const Duration(seconds: 4));

      // Verify we are on the list page
      expect(find.text('Restaurant App'), findsWidgets);
      
      // Find the first list item by type Card or InkWell
      final firstRestaurantCard = find.byType(Card).first;
      expect(firstRestaurantCard, findsOneWidget);

      // Tap on it
      await tester.tap(firstRestaurantCard);
      
      // Wait for transition and detail API fetch
      await tester.pumpAndSettle(const Duration(seconds: 4));

      // Verify we are on the detail page
      expect(find.text('Restaurant Detail'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Reviews'), findsOneWidget);
    });
  });
}
