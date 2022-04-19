import 'dart:math';
import 'dart:ui';

import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HingeAngle extends StatelessWidget {
  const HingeAngle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hinge Angle'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) => TwoPane(
          panePriority: TwoPanePriority.both,
          direction: orientation == Orientation.landscape
              ? Axis.horizontal
              : Axis.vertical,
          paneProportion: orientation == Orientation.landscape ? 0.6 : 0.4,
          startPane: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Table(
              border: TableBorder.all(color: Colors.black),
              columnWidths: {
                0: FractionColumnWidth(0.3),
                1: FractionColumnWidth(0.11),
              },
              children: [
                row(
                  Text('Variable'),
                  Text('Value'),
                  Text('Explanation'),
                ),
                row(
                  Text('MediaQuery\ndisplayFeatures\ntype'),
                  Text(formatDisplayFeatureTypes(MediaQuery.of(context).displayFeatures)),
                  Text(
                      'Can be Hinge, Fold or Cutout. Reported only if application overlaps the display feature.'),
                ),
                row(
                  Text('MediaQuery\ndisplayFeatures\nstate'),
                  Text(formatDisplayFeaturePostures(MediaQuery.of(context).displayFeatures)),
                  Text(
                      'Posture is the shape that the display makes. Reported only when app is spanned.'),
                ),
                row(
                  Text('DualScreenInfo.\nhasHingeAngleSensor'),
                  FutureBuilder<bool>(
                    future: DualScreenInfo.hasHingeAngleSensor,
                    builder: (context, hasHingeAngleSensor) {
                      return Text(
                          hasHingeAngleSensor.data?.toString() ?? 'N/A');
                    },
                  ),
                  Text(
                      'Reports if the device has a hinge angle sensor, even if app is not spanned.'),
                ),
                row(
                  Text('DualScreenInfo.\nhingeAngleEvents'),
                  StreamBuilder<double>(
                    stream: DualScreenInfo.hingeAngleEvents,
                    builder: (context, hingeAngle) {
                      return Text(
                          hingeAngle.data?.toStringAsFixed(2) ?? 'N/A*');
                    },
                  ),
                  Text(
                      'Latest hinge angle, reported even when the app is not spanned.'),
                ),
              ],
            ),
          ),
          endPane: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder<double>(
              stream: DualScreenInfo.hingeAngleEvents,
              builder: (context, hingeAngle) {
                if (hingeAngle.data == null) {
                  return Center(
                      child: Text(
                          '* This sample shows you what the value of the hinge angle is. This requires a foldable or dual screen device or emulator. The emulator has an "Extended Controls" window where you can change the angle.'));
                } else {
                  return AngleIndicator(angle: hingeAngle.data!);
                }
              },
            ),
          ),
          padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top),
        ),
      ),
    );
  }

  TableRow row(Widget a, b, c) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
        child: a,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
        child: b,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
        child: c,
      ),
    ]);
  }

  String formatDisplayFeatureTypes(List<ui.DisplayFeature> displayFeatures) {
    if (displayFeatures.isEmpty) {
      return 'N/A';
    } else {
      return displayFeatures.map((e) => formatType(e.type)).join(', ');
    }
  }

  String formatDisplayFeaturePostures(List<ui.DisplayFeature> displayFeatures) {
    if (displayFeatures.isEmpty) {
      return 'N/A';
    } else {
      return displayFeatures.map((e) => formatPosture(e.state)).join(', ');
    }
  }

  String formatType(ui.DisplayFeatureType displayFeatureType) {
    switch (displayFeatureType) {
      case DisplayFeatureType.hinge:
        return 'Hinge';
      case DisplayFeatureType.fold:
        return 'Fold';
      case DisplayFeatureType.cutout:
        return 'Fold';
      case DisplayFeatureType.unknown:
      default:
        return 'unknown';
    }
  }

  String formatPosture(ui.DisplayFeatureState displayFeatureState) {
    switch (displayFeatureState) {
      case DisplayFeatureState.postureFlat:
        return 'Flat';
      case DisplayFeatureState.postureHalfOpened:
        return 'HalfOpened';
      case DisplayFeatureState.unknown:
      default:
        return 'unknown';
    }
  }
}

class AngleIndicator extends StatelessWidget {
  final double angle;

  const AngleIndicator({Key? key, required this.angle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: AnglePainter(
                    angle: angle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Text(
                    '${angle.toStringAsFixed(2)}°',
                    style: TextStyle(fontSize: 48),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnglePainter extends CustomPainter {
  final double angle;
  final Color color;

  AnglePainter({required this.angle, this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final radians = angle * (pi / 180);
    canvas.drawArc(
      Offset(0, 0) & size,
      -pi / 2 - radians / 2, //radians
      radians, //radians
      true,
      paint1,
    );
  }

  @override
  bool shouldRepaint(AnglePainter oldDelegate) =>
      oldDelegate.angle != angle || oldDelegate.color != color;
}
