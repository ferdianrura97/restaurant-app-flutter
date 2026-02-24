import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/pages/restaurant_list_page.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/theme_provider.dart';
import 'package:restaurant_app/utils/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
    '4. Verify RestaurantListPage renders title and subtitle text correctly',
    (WidgetTester tester) async {
      // Setup a dummy SharedPreferences for ThemeProvider
      SharedPreferences.setMockInitialValues({});
      final preferencesHelper = PreferencesHelper(
        sharedPreferences: SharedPreferences.getInstance(),
      );

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) =>
                  ThemeProvider(preferencesHelper: preferencesHelper),
            ),
            ChangeNotifierProvider(
              create: (_) => RestaurantListProvider(apiService: ApiService()),
            ),
          ],
          child: const MaterialApp(home: RestaurantListPage()),
        ),
      );

      // Verify that the title text is found.
      expect(find.text('Restaurant App'), findsWidgets);
      expect(find.text('Recommendation restauran for you!'), findsOneWidget);

      // Find the settings icon
      expect(find.byIcon(Icons.settings), findsOneWidget);
      // Find the search icon
      expect(find.byIcon(Icons.search), findsOneWidget);
      // Find the favorite icon
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    },
  );
}
