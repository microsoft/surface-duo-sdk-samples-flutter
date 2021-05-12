import 'package:dual_screen_samples/two_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

List<SampleMeta> sampleCatalogue = [
  SampleMeta(
    'Two Page',
    'A book-like reading experience with swipe gestures',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/two_page/two_page.dart',
    '/two-page',
    (context) => TwoPageSample(),
  ),
  SampleMeta(
    'Two Page 2',
    'A book-like reading experience with swipe gestures',
    'https://github.com/microsoft/flutter-dualscreen-samples/blob/main/lib/two_page/two_page.dart',
    '/two-page2',
    (context) => TwoPageSample(),
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
        pane1: Container(
          child: ListView.builder(
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
                    launch(sampleCatalogue[index].link);
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
        ),
        pane2: Container(),
        panePriority: MediaQuery.of(context).hinge == null
            ? TwoPanePriority.pane1
            : TwoPanePriority.both,
      ),
    );
  }
}
