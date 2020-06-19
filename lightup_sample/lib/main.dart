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
  bool _isDualScreenDevice = false;
  bool _isAppSpanned = false;
  double _hingeAngle = 180.0;
  int _hingeSize = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    platform.invokeMethod('isDualScreenDevice').then((value) {
      _isDualScreenDevice = value;
    });
  }

  // Surface Duo: We'll use this simple function to query the APIs and report their values
  Future<void> _updateDualScreenInfo() async {
    print("_updateDualScreenInfo() - Start");
    _isAppSpanned = await platform.invokeMethod('isAppSpanned');
    _hingeAngle = await platform.invokeMethod('getHingeAngle');
    _hingeSize = await platform.invokeMethod('getHingeSize');
    print("_updateDualScreenInfo() - End");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<void>(
        future: _updateDualScreenInfo(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return _createPage();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _createPage() {
    print("CreatePage()");

    if (!_isDualScreenDevice || (_isDualScreenDevice && !_isAppSpanned)) {
      // We are not on a dual-screen device or
      // we are but we are not spanned
      return _buildBody();
    } else {
      // We are on a dual-screen device and we are spanned
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        // Portrait is what we get when we have rotated the device
        // and have two "landscape" screens on top of each other,
        // so together they are "portrait"
        return Column(
          children: [
            Flexible(
              flex: 1,
              child: Center(child: FlutterLogo(size: 200.0)),
            ),
            SizedBox(height: _hingeSize.toDouble()),
            Flexible(
              flex: 1,
              child: _buildBody(),
            ),
          ],
        );
      } else {
        return Row(
          children: [
            Flexible(
              flex: 1,
              child: Center(child: FlutterLogo(size: 200.0)),
            ),
            SizedBox(width: _hingeSize.toDouble()),
            Flexible(
              flex: 1,
              child: _buildBody(),
            ),
          ],
        );
      }
    }
  }

  Widget _buildBody() {
    print("CreatePage()");
    return Center(
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
    );
  }
}
