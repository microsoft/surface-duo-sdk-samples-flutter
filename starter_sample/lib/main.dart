/*
  For Readability I've stripped out the boilerplate comments
  that would normall be in the template code
*/
import 'package:flutter/material.dart';

// Surface Duo: Add for Platform Channel support
import 'package:flutter/services.dart';
// Surface Duo: Define the Method Channel name
const platform = const MethodChannel('duosdk.microsoft.dev');

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Surface Duo: We'll use this simple function to query the APIs and report their values
  void _updateDualScreenInfo() async {
    final bool isDual = await platform.invokeMethod('isDualScreenDevice');
    final bool isSpanned = await platform.invokeMethod('isAppSpanned');
    final double hingeAngle = await platform.invokeMethod('getHingeAngle');

    print('isDualScreenDevice : $isDual');
    print('isAppSpanned : $isSpanned');
    print('hingeAngle : $hingeAngle');
  }

  @override
  Widget build(BuildContext context) {
    // Surface Duo: Get the current status each time we run the build method.
    //      In a real app you would probably not do this and would
    //      watch for orientation change or monitor a stream
    _updateDualScreenInfo();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
