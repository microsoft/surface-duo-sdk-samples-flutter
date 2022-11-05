import 'package:dual_screen/dual_screen.dart';
import 'package:dual_screen_samples/companion_pane/companion_pane.dart';
import 'package:dual_screen_samples/dialogs_demo/dialogs_demo.dart';
import 'package:dual_screen_samples/dual_view_notepad/dual_view_notepad.dart';
import 'package:dual_screen_samples/dual_view_restaurants/dual_view_restaurants.dart';
import 'package:dual_screen_samples/extended_canvas/extended_canvas.dart';
import 'package:dual_screen_samples/hinge_angle/hinge_angle.dart';
import 'package:dual_screen_samples/list_detail/list_detail.dart';
import 'package:dual_screen_samples/two_page/two_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

List<SampleMeta> sampleCatalogue = [
  SampleMeta(
    'Extended Canvas',
    'View locations on a map extended across both screens.',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/extended_canvas/extended_canvas.dart',
    '/extended-canvas',
    (context) => ExtendedCanvas(),
  ),
  SampleMeta(
    'List Detail',
    'List of images on one screen and image details on the other screen.',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/list_detail/list_detail.dart',
    '/list-detail',
    (context) => ListDetail(),
  ),
  SampleMeta(
    'Two Page',
    'A book-like reading experience. You can see two pages simultaneously.',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/two_page/two_page.dart',
    '/two-page',
    (context) => TwoPage(),
  ),
  SampleMeta(
    'Dual View Notepad',
    'Edit markdown on one screen and preview results on the other.',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/dual_view_notepad/dual_view_notepad.dart',
    '/dual-view-notepad',
    (context) => DualViewNotepad(),
  ),
  SampleMeta(
    'Dual View Restaurants',
    'A list of restaurants on one screen and a map with pins on the other.',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/dual_view_restaurants/dual_view_restaurants.dart',
    '/dual-view-restaurants',
    (context) => DualViewRestaurants(),
  ),
  SampleMeta(
    'Companion Pane',
    'Image editor with a preview on one screen and the filters on the other.',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/companion_pane/companion_pane.dart',
    '/companion-pane',
    (context) => CompanionPane(),
  ),
  SampleMeta(
    'Hinge Angle',
    'Interact with the hinge hardware to see the angle change the UI.',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/hinge_angle/hinge_angle.dart',
    '/hinge-angle',
    (context) => HingeAngle(),
  ),

  SampleMeta(
    'Dialogs Demo',
    'Pick what screen a dialog uses on dual-screen devices.',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/dialogs_demo/dialogs_demo.dart',
    '/dialogs-demo',
        (context) => DialogsDemo(),
  ),
];

class SampleMeta {
  final String title, subtitle, link, route;
  final WidgetBuilder builder;

  SampleMeta(this.title, this.subtitle, this.link, this.route, this.builder);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dual Screen Samples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SamplesList(),
      routes: Map.fromEntries(sampleCatalogue.map(
        (sample) => MapEntry(sample.route, sample.builder),
      )),
    );
  }
}

class SamplesList extends StatelessWidget {
  const SamplesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Samples list'),
      ),
      body: TwoPane(
        startPane: ListView.builder(
          itemCount: sampleCatalogue.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(sampleCatalogue[index].title),
              subtitle: Text(sampleCatalogue[index].subtitle),
              onTap: () {
                Navigator.of(context).pushNamed(sampleCatalogue[index].route);
              },
              trailing: PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Expanded(child: Text("View Code")),
                          SizedBox(width: 16),
                          Icon(Icons.open_in_new),
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (_) {
                  launchUrl(Uri.parse(sampleCatalogue[index].link));
                },
                child: Container(
                  width: 48,
                  height: 48,
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  alignment: Alignment.center,
                  child: Icon(Icons.more_vert),
                ),
              ),
            );
          },
        ),
        endPane: Container(),
        panePriority: TwoPanePriority.start,
        padding: EdgeInsets.only(
            top: kToolbarHeight + MediaQuery.of(context).padding.top),
      ),
    );
  }
}
