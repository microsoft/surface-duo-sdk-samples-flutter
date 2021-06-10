import 'package:dual_screen_samples/two_page/data.dart';
import 'package:dual_screen_samples/two_page/two_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'display_feature_mocks.dart';

void main() {
  group('Two Page', () {
    testWidgets('Two Page shows only one page in portrait single-screen',
        (WidgetTester tester) async {
      // Given a portrait single-screen device
      tester.binding.window.physicalSizeTestValue = Size(1800, 2400);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: TwoPage()));

      // Then page 1 is visible
      expect(find.byType(Page1), findsOneWidget);
      // And page 2 is not visible
      expect(find.byType(Page2), findsNothing);
    });

    testWidgets('Two Page shows only one page in landscape single-screen',
        (WidgetTester tester) async {
      // Given a landscape single-screen device
      tester.binding.window.physicalSizeTestValue = Size(2400, 1800);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: TwoPage()));

      // Then page 1 is visible
      expect(find.byType(Page1), findsOneWidget);
      // And page 2 is not visible
      expect(find.byType(Page2), findsNothing);
    });

    testWidgets('Two Page shows two pages in dual-portrait',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-portrait
      mockDualScreenPortrait(tester);
      _makeTextSmaller(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: TwoPage()));

      // Then page 1 is visible
      expect(find.byType(Page1), findsOneWidget);
      // And page 2 is also visible
      expect(find.byType(Page2), findsOneWidget);
    });

    testWidgets('Two Page shows two pages in dual-landscape',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-landscape
      mockDualScreenLandscape(tester);
      _makeTextSmaller(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: TwoPage()));

      // Then page 1 is visible
      expect(find.byType(Page1), findsOneWidget);
      // And page 2 is also visible
      expect(find.byType(Page2), findsOneWidget);
    });
  });
}

/// Some of the pages in the Two Page sample do not fit on the screen during
/// tests because the Flutter test setup uses the Ahem font. In a normal, for
/// production app, this should be fixed by dynamically calculating page
/// contents.
///
/// For the purpose of these example tests, we just make the text smaller. This
/// hack should not be picked up as valid test procedures.
void _makeTextSmaller(WidgetTester tester) {
  tester.binding.window.textScaleFactorTestValue = 0.5;
  addTearDown(() {
    tester.binding.window.clearTextScaleFactorTestValue();
  });
}
