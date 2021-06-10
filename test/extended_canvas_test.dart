import 'package:dual_screen_samples/dual_view_restaurants/mock_widgets.dart';
import 'package:dual_screen_samples/extended_canvas/extended_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'display_feature_mocks.dart';

void main() {
  group('Extended Canvas', () {
    testWidgets('Extended Canvas shows bottom sheet on second screen',
        (WidgetTester tester) async {
      // Given a dual-screen dual-portrait device
      mockDualScreenPortrait(tester);
      await tester.pumpWidget(MaterialApp(home: ExtendedCanvas()));

      // When I tap on an icon
      await tester.tap(find.byType(Icon).first);

      await tester.pumpAndSettle();

      // Then I see Restaurant details
      expect(find.byType(RestaurantDetails), findsOneWidget);

      // And I see it on the right screen
      final modalCenter = tester.getCenter(find.byType(RestaurantDetails));
      final screens = getScreens(tester);

      expect(
        screens[1].contains(modalCenter),
        isTrue,
        reason: 'Second screen does not contain center of modal',
      );
    });
  });
}
