import 'package:dual_screen_samples/hinge_angle/hinge_angle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'display_feature_mocks.dart';

void main() {
  // Ensure channels are initialised
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Hinge Angle', () {
    testWidgets('Hinge Angle detects hinge sensor and streams values',
        (WidgetTester tester) async {
      // Given hinge sensor exists
      mockHingeExistsCall(true);
      // And given hinge sensor emits a value
      mockHingeAngleStream([175.9]);


      // When the widget loads and settles (streamed values come in)
      await tester.pumpWidget(MaterialApp(home: HingeAngle()));
      await tester.pumpAndSettle();

      // Then 'true' is visible on screen (only `hasHingeAngleSensor` shows a
      // boolean on screen.
      expect(find.text('true'), findsOneWidget);

      // And 175.90 is displayed on screen
      expect(find.text('175.90'), findsOneWidget);
    });

    testWidgets('Hinge Angle shows half opened posture',
        (WidgetTester tester) async {
      // Given a foldable phone with half opened posture
      mockFoldableHalfOpened(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: HingeAngle()));

      // Then the posture is shown as text
      expect(find.text('HalfOpened'), findsOneWidget);
    });

    testWidgets('Hinge Angle shows flat posture', (WidgetTester tester) async {
      // Given a foldable phone with half opened posture
      mockDualScreenLandscape(tester);

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: HingeAngle()));

      // Then the posture is shown as text
      expect(find.text('Flat'), findsOneWidget);
    });

    testWidgets('Hinge Angle shows no hinge sensor and no posture',
        (WidgetTester tester) async {
      // Given no special configuration

      // When the widget loads
      await tester.pumpWidget(MaterialApp(home: HingeAngle()));

      // Then posture and hasHingeAngleSensor are both N/A
      expect(find.text('N/A'), findsNWidgets(3));
      // And the stream of hinge angle values show N/A*
      expect(find.text('N/A*'), findsOneWidget);
    });
  });
}
