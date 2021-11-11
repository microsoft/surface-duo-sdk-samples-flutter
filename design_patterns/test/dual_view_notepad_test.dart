import 'package:dual_screen_samples/dual_view_notepad/dual_view_notepad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';

import 'display_feature_mocks.dart';

void main() {
  group('Dual View Notepad', () {
    testWidgets(
        'Dual View Notepad only shows the editor in portrait single-screen',
        (WidgetTester tester) async {
      // Given a portrait single-screen device
      tester.binding.window.physicalSizeTestValue = Size(1800, 2400);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: DualViewNotepad()));

      // Then the list is visible
      expect(find.byType(TextField), findsOneWidget);
      // And the map is not visible
      expect(find.byType(Markdown), findsNothing);
    });

    testWidgets(
        'Dual View Notepad only shows the editor in landscape single-screen',
        (WidgetTester tester) async {
      // Given a landscape single-screen device
      tester.binding.window.physicalSizeTestValue = Size(2400, 1800);
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
      });

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: DualViewNotepad()));

      // Then the list is visible
      expect(find.byType(TextField), findsOneWidget);
      // And the map is not visible
      expect(find.byType(Markdown), findsNothing);
    });

    testWidgets(
        'Dual View Notepad shows both editor and preview in dual-portrait',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-portrait
      mockDualScreenPortrait(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: DualViewNotepad()));

      // Then the list is visible
      expect(find.byType(TextField), findsOneWidget);
      // And the map is also visible
      expect(find.byType(Markdown), findsOneWidget);
    });

    testWidgets(
        'Dual View Notepad shows both editor and preview in dual-landscape',
        (WidgetTester tester) async {
      // Given a dual-screen device in dual-landscape
      mockDualScreenLandscape(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: DualViewNotepad()));

      // Then the list is visible
      expect(find.byType(TextField), findsOneWidget);
      // And the map is also visible
      expect(find.byType(Markdown), findsOneWidget);
    });
  });
}
