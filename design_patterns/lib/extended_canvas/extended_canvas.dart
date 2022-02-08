import 'package:dual_screen_samples/dual_view_restaurants/data.dart';
import 'package:dual_screen_samples/dual_view_restaurants/dual_view_restaurants.dart';
import 'package:dual_screen_samples/dual_view_restaurants/mock_widgets.dart';
import 'package:dual_screen_samples/mediaquery_hinge.dart';
import 'package:flutter/material.dart';

class ExtendedCanvas extends StatefulWidget {
  const ExtendedCanvas({Key? key}) : super(key: key);

  @override
  _ExtendedCanvasState createState() => _ExtendedCanvasState();
}

class _ExtendedCanvasState extends State<ExtendedCanvas> {
  final List<Restaurant> restaurants = restaurants_repo;
  int? selectedRestaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Extended Canvas')),
      body: MapPane(
        restaurants: restaurants,
        selectedRestaurant: selectedRestaurant,
        onPinTap: (index) {
          openRestaurant(context, index);
        },
        onPopupTap: (index) {},
        singleScreen: false,
      ),
    );
  }

  void openRestaurant(BuildContext context, int? index) async {
    setState(() {
      selectedRestaurant = index;
    });
    if (index != null) {
      await showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxWidth: 600),
        builder: (context) {
          return RestaurantDetails(restaurant: restaurants[index]);
        },
        anchorPoint: _roughLocationOnScreen(context, index),
      );
      setState(() {
        selectedRestaurant = null;
      });
    }
  }

  /// Restaurant latLong vary from -1 to 1 and we map that to coordinates on the
  /// screen.
  Offset _roughLocationOnScreen(BuildContext context, int index) {
    if ((MediaQuery.of(context).hinge?.bounds.size.aspectRatio ?? 0) > 1) {
      // When the hinge separates the screens top-bottom, we always use the
      // bottom screen.
      return Offset(0.0, 1000);
    }
    final restaurantLocation = restaurants[index].latLong;
    final screenSize = MediaQuery.of(context).size;
    return Offset((restaurantLocation.lat + 1) * screenSize.width / 2,
        (restaurantLocation.long + 1) * screenSize.height / 2);
  }
}
