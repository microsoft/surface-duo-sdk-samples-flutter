import 'package:dual_screen/dual_screen.dart';
import 'package:dual_screen_samples/two_page/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TwoPage extends StatefulWidget {
  const TwoPage({Key? key}) : super(key: key);

  @override
  _TwoPageState createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    // Default values for single screen mode
    Axis axis = Axis.horizontal;
    double viewPortFraction = 1.0;
    Size pageSize = MediaQuery.of(context).size;
    Size lastPageSize = MediaQuery.of(context).size;
    EdgeInsets pagePadding = EdgeInsets.zero;
    EdgeInsets lastPagePadding = EdgeInsets.zero;
    final isDualScreen = MediaQuery.of(context).hinge != null;
    if (isDualScreen) {
      final Size hingeSize = MediaQuery.of(context).hinge?.bounds.size ?? Size.zero;
      axis = hingeSize.aspectRatio > 1.0 ? Axis.vertical : Axis.horizontal;
      if (axis == Axis.horizontal) {
        // Dual-screen with screens left-and-right
        pageSize = Size(MediaQuery.of(context).hinge!.bounds.right,
            MediaQuery.of(context).size.height);
        pagePadding = EdgeInsets.only(right: hingeSize.width);
        lastPageSize = Size(pageSize.width - hingeSize.width, pageSize.height);
        viewPortFraction = pageSize.width / MediaQuery.of(context).size.width;
      } else {
        // Dual-screen with screens top-and-bottom
        pageSize = Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).hinge!.bounds.bottom);
        pagePadding = EdgeInsets.only(bottom: hingeSize.height);
        lastPageSize = Size(pageSize.width, pageSize.height - hingeSize.height);
        lastPagePadding = EdgeInsets.only();
        viewPortFraction =
            pageSize.height / (MediaQuery.of(context).size.height);
      }
    } else if (MediaQuery.of(context).size.longestSide > 1000) {
      // Dual-screen with screens top-and-bottom
      pageSize = Size(MediaQuery.of(context).size.width / 2,
          MediaQuery.of(context).size.height);
      pagePadding = EdgeInsets.zero;
      lastPageSize = Size(pageSize.width / 2, pageSize.height);
      lastPagePadding = EdgeInsets.zero;
      viewPortFraction =
          pageSize.height / (MediaQuery.of(context).size.height);
    }
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            scrollDirection: axis,
            physics: PageScrollPhysics(),
            controller: PageController(viewportFraction: viewPortFraction),
            children: [
              Container(
                width: pageSize.width,
                height: pageSize.height,
                padding: pagePadding,
                child: Page1(),
              ),
              Container(
                width: pageSize.width,
                height: pageSize.height,
                padding: pagePadding,
                child: Page2(),
              ),
              Container(
                width: pageSize.width,
                height: pageSize.height,
                padding: pagePadding,
                child: Page3(),
              ),
              Container(
                width: lastPageSize.width,
                height: lastPageSize.height,
                padding: lastPagePadding,
                child: Page4(),
              ),
            ],
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              mini: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
