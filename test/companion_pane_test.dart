import 'package:dual_screen_samples/companion_pane/companion_pane.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'display_feature_mocks.dart';

void main() {
  group('Companion Pane', () {
    testWidgets(
        'Companion Pane shows only one slider in portrait single-screen',
        (WidgetTester tester) async {
      // Given a portrait single-screen device
      tester.binding.window.physicalSizeTestValue = Size(1800, 2400);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: CompanionPane()));

      // Then a single slider is visible
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets(
        'Companion Pane shows only one slider in landscape single-screen',
        (WidgetTester tester) async {
      // Given a landscape single-screen device
      tester.binding.window.physicalSizeTestValue = Size(2400, 1800);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: CompanionPane()));

      // Then a single slider is visible
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('Companion Pane shows multiple sliders in dual-portrait',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-portrait
      mockDualScreenPortrait(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: CompanionPane()));

      // Then all sliders are visible
      expect(find.byType(Slider), findsNWidgets(6));
    });

    testWidgets('Companion Pane shows multiple sliders in dual-landscape',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-landscape
      mockDualScreenLandscape(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: CompanionPane()));

      // Then all sliders are visible
      expect(find.byType(Slider), findsNWidgets(6));
    });
  });
}
