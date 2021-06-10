import 'package:dual_screen_samples/dual_view_restaurants/dual_view_restaurants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'display_feature_mocks.dart';

void main() {
  group('Dual View Restaurants', () {
    testWidgets(
        'Dual View Restaurants only shows a list in portrait single-screen',
        (WidgetTester tester) async {
      // Given a portrait single-screen device
      tester.binding.window.physicalSizeTestValue = Size(1800, 2400);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: DualViewRestaurants()));

      // Then the list is visible
      expect(find.byType(ListPane), findsOneWidget);
      // And the map is not visible
      expect(find.byType(MapPane), findsNothing);
    });

    testWidgets(
        'Dual View Restaurants only shows a list in landscape single-screen',
        (WidgetTester tester) async {
      // Given a landscape single-screen device
      tester.binding.window.physicalSizeTestValue = Size(2400, 1800);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: DualViewRestaurants()));

      // Then the list is visible
      expect(find.byType(ListPane), findsOneWidget);
      // And the map is not visible
      expect(find.byType(MapPane), findsNothing);
    });

    testWidgets(
        'Dual View Restaurants shows both list and map in dual-portrait',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-portrait
      mockDualScreenPortrait(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: DualViewRestaurants()));

      // Then the list is visible
      expect(find.byType(ListPane), findsOneWidget);
      // And the map is also visible
      expect(find.byType(MapPane), findsOneWidget);
    });

    testWidgets(
        'Dual View Restaurants shows both list and map in dual-landscape',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-landscape
      mockDualScreenLandscape(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: DualViewRestaurants()));

      // Then the list is visible
      expect(find.byType(ListPane), findsOneWidget);
      // And the map is also visible
      expect(find.byType(MapPane), findsOneWidget);
    });
  });
}
