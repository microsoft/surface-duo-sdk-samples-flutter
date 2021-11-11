import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:ui' as ui;

/// Mocks the stream of hinge angle values that comes from native to dart,
/// exposed by [DualScreenInfo.hingeAngleEvents].
///
/// Clears any mock handlers that were configured for [HINGE_ANGLE_CHANNEL].
void mockHingeAngleStream(List<double> multipleSensorValues) {
  const StandardMethodCodec standardMethod = StandardMethodCodec();
  String channelName = 'com.microsoft.flutterdualscreen/hinge_angle';

  ServicesBinding.instance!.defaultBinaryMessenger
      .setMockMessageHandler(channelName, (ByteData? message) async {
    final MethodCall methodCall = standardMethod.decodeMethodCall(message);
    if (methodCall.method == 'listen') {
      multipleSensorValues.forEach((element) {
        ServicesBinding.instance!.defaultBinaryMessenger.handlePlatformMessage(
          channelName,
          standardMethod.encodeSuccessEnvelope(element),
              (ByteData? reply) {},
        );
      });
      ServicesBinding.instance!.defaultBinaryMessenger.handlePlatformMessage(
        channelName,
        null,
            (ByteData? reply) {},
      );
      return standardMethod.encodeSuccessEnvelope(null);
    } else if (methodCall.method == 'cancel') {
      return standardMethod.encodeSuccessEnvelope(null);
    } else {
      fail('Expected listen or cancel');
    }
  });

  addTearDown(() {
    ServicesBinding.instance!.defaultBinaryMessenger
        .setMockMessageHandler(channelName, null);
  });
}

/// Mocks if the device is equipped with a hinge angle sensor or not, exposed by
/// [DualScreenInfo.hasHingeAngleSensor].
///
/// Clears any mock handlers that were configured for [HINGE_INFO_CHANNEL].
void mockHingeExistsCall(bool hingeExists) {
  const MethodChannel HINGE_INFO_CHANNEL = MethodChannel('com.microsoft.flutterdualscreen/hinge_info');
  HINGE_INFO_CHANNEL.setMockMethodCallHandler((MethodCall methodCall) async {
    return hingeExists;
  });

  addTearDown(() {
    HINGE_INFO_CHANNEL.setMockMethodCallHandler(null);
  });
}

/// Configures the current test window to simulate a Surface Duo in dual
/// portrait mode (screens are positioned left-right with the hinge area
/// vertically).
///
/// Clears window size, density and display features during test teardown.
///
/// Also see:
///  * [Surface Duo Dimensions](https://docs.microsoft.com/en-us/dual-screen/android/duo-dimensions)
void mockDualScreenPortrait(WidgetTester tester) {
  tester.binding.window.physicalSizeTestValue = Size(2784, 1800);
  tester.binding.window.devicePixelRatioTestValue = 2.5;
  tester.binding.window.displayFeaturesTestValue = [
    const ui.DisplayFeature(
      // DisplayFeature bounds is represented in density independent pixels (dp)
      // Please take this into account when working with them in tests,
      // especially since most other device sizes are represented in physical
      // pixels (like the physicalSizeTestValue at the start of this method).
      bounds: const Rect.fromLTRB(540, 0, 573.6, 720),
      type: ui.DisplayFeatureType.hinge,
      state: ui.DisplayFeatureState.postureFlat,
    ),
  ];
  addTearDown(() {
    tester.binding.window.clearPhysicalSizeTestValue();
    tester.binding.window.clearDevicePixelRatioTestValue();
    tester.binding.window.clearDisplayFeaturesTestValue();
  });
}

/// Configures the current test window to simulate a Surface Duo in dual
/// landscape mode (screens are positioned up-down with the hinge area
/// horizontally).
///
/// Clears window size, density and display features during test teardown.
///
/// Also see:
///  * [Foldable Postures](https://developer.android.com/guide/topics/ui/foldables#postures)
void mockDualScreenLandscape(WidgetTester tester) {
  tester.binding.window.physicalSizeTestValue = Size(1800, 2784);
  tester.binding.window.devicePixelRatioTestValue = 2.5;
  tester.binding.window.displayFeaturesTestValue = [
    const ui.DisplayFeature(
      // DisplayFeature bounds is represented in density independent pixels (dp)
      // Please take this into account when working with them in tests,
      // especially since most other device sizes are represented in physical
      // pixels (like the physicalSizeTestValue at the start of this method).
      bounds: const Rect.fromLTRB(0, 540, 720, 573.6),
      type: ui.DisplayFeatureType.hinge,
      state: ui.DisplayFeatureState.postureFlat,
    ),
  ];
  addTearDown(() {
    tester.binding.window.clearPhysicalSizeTestValue();
    tester.binding.window.clearDevicePixelRatioTestValue();
    tester.binding.window.clearDisplayFeaturesTestValue();
  });
}

/// Configures the current test window to simulate a single-screen foldable in
/// portrait mode with the two parts of the screen at 90 degrees (Half Opened
/// posture, hinge area is 0-width).
///
/// Clears window size, density and display features during test teardown.
///
/// Also see:
///  * [Surface Duo Dimensions](https://docs.microsoft.com/en-us/dual-screen/android/duo-dimensions)
void mockFoldableHalfOpened(WidgetTester tester) {
  tester.binding.window.physicalSizeTestValue = Size(2784, 1800);
  tester.binding.window.devicePixelRatioTestValue = 2.5;
  tester.binding.window.displayFeaturesTestValue = [
    const ui.DisplayFeature(
      // DisplayFeature bounds is represented in density independent pixels (dp)
      // Please take this into account when working with them in tests,
      // especially since most other device sizes are represented in physical
      // pixels (like the physicalSizeTestValue at the start of this method).
      bounds: const Rect.fromLTRB(556.8, 0, 556.8, 720),
      type: ui.DisplayFeatureType.fold,
      state: ui.DisplayFeatureState.postureHalfOpened,
    ),
  ];
  addTearDown(() {
    tester.binding.window.clearPhysicalSizeTestValue();
    tester.binding.window.clearDevicePixelRatioTestValue();
    tester.binding.window.clearDisplayFeaturesTestValue();
  });
}

/// Get a list of screens on the device.
///
/// For a single-screen device, this will return one rectangle at 0,0 with the
/// size of the device. On dual-screen devices, this will return one rectangle
/// for each screen.
List<Rect> getScreens(WidgetTester tester) {
  MediaQuery mq = tester.firstWidget(find.byType(MediaQuery));
  MediaQueryData mediaQuery = mq.data;
  if (mediaQuery.hinge == null) {
    return [
      Rect.fromLTRB(
        0,
        0,
        mediaQuery.size.width,
        mediaQuery.size.height,
      )
    ];
  } else {
    if (mediaQuery.hinge!.bounds.top == 0) {
      // Hinge is vertical, makes a left-right split
      return [
        Rect.fromLTRB(
          0,
          0,
          mediaQuery.hinge!.bounds.left,
          mediaQuery.size.height,
        ),
        Rect.fromLTRB(
          mediaQuery.hinge!.bounds.right,
          0,
          mediaQuery.size.width,
          mediaQuery.size.height,
        ),
      ];
    } else {
      // Hinge is horizontal, makes a up-down split
      return [
        Rect.fromLTRB(
          0,
          0,
          mediaQuery.size.width,
          mediaQuery.hinge!.bounds.top,
        ),
        Rect.fromLTRB(
          0,
          mediaQuery.hinge!.bounds.bottom,
          mediaQuery.size.width,
          mediaQuery.size.height,
        ),
      ];
    }
  }
}
