import 'package:dual_screen_samples/two_page/data.dart';
import 'package:flutter/material.dart';

class TwoPage extends StatelessWidget {
  const TwoPage({Key? key}) : super(key: key);

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
      final Size hingeSize = MediaQuery.of(context).hinge!.bounds.size;
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
        final barsHeight =
            MediaQuery.of(context).viewPadding.top + kToolbarHeight;
        pageSize = Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).hinge!.bounds.bottom - barsHeight);
        pagePadding = EdgeInsets.only(bottom: hingeSize.height);
        lastPageSize = Size(
            pageSize.width, pageSize.height + barsHeight - hingeSize.height);
        lastPagePadding = EdgeInsets.only(bottom: barsHeight);
        viewPortFraction =
            pageSize.height / (MediaQuery.of(context).size.height - barsHeight);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Two Page'),
      ),
      body: ListView(
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
    );
  }
}