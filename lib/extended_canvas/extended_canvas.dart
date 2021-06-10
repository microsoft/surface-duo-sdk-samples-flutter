import 'package:dual_screen_samples/dual_view_restaurants/data.dart';
import 'package:dual_screen_samples/dual_view_restaurants/dual_view_restaurants.dart';
import 'package:dual_screen_samples/dual_view_restaurants/mock_widgets.dart';
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
      await showModalBottomSheet(context: context, builder: (context) {
        return RestaurantDetails(restaurant: restaurants[index]);
      }, anchorPoint: Offset(0.0, double.infinity));
      setState(() {
        selectedRestaurant = null;
      });
    }
  }
}
