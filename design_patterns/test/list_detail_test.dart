import 'package:dual_screen_samples/list_detail/list_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'display_feature_mocks.dart';

void main() {
  group('List Detail', () {
    testWidgets(
        'List Detail only shows the list in portrait single-screen',
        (WidgetTester tester) async {
      // Given a portrait single-screen device
      tester.binding.window.physicalSizeTestValue = Size(1800, 2400);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: ListDetail()));

      // Then the list is visible
      expect(find.byType(ListPane), findsOneWidget);
      // And the details are not visible
      expect(find.byType(DetailsPane), findsNothing);
    });

    testWidgets(
        'List Detail only shows the list in landscape single-screen',
        (WidgetTester tester) async {
      // Given a landscape single-screen device
      tester.binding.window.physicalSizeTestValue = Size(2400, 1800);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: ListDetail()));

      // Then the list is visible
      expect(find.byType(ListPane), findsOneWidget);
      // And the details are not visible
      expect(find.byType(DetailsPane), findsNothing);
    });

    testWidgets(
        'List Detail shows both the list and details in dual-portrait',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-portrait
      mockDualScreenPortrait(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: ListDetail()));

      // Then the list is visible
      expect(find.byType(ListPane), findsOneWidget);
      // And the details are also visible
      expect(find.byType(DetailsPane), findsOneWidget);
    });

    testWidgets(
        'List Detail only shows the list in dual-landscape',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-landscape
      mockDualScreenLandscape(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: ListDetail()));

      // Then the list is visible
      expect(find.byType(ListPane), findsOneWidget);
      // And the details are not visible
      expect(find.byType(DetailsPane), findsNothing);
    });
  });
}
