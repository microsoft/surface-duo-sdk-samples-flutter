import 'package:dual_screen_samples/dual_view_restaurants/data.dart';
import 'package:dual_screen_samples/mediaquery_hinge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'mock_widgets.dart';

class DualViewRestaurants extends StatefulWidget {
  const DualViewRestaurants({Key? key}) : super(key: key);

  @override
  _DualViewRestaurantsState createState() => _DualViewRestaurantsState();
}

class _DualViewRestaurantsState extends State<DualViewRestaurants> {
  final List<Restaurant> restaurants = restaurants_repo;
  int? selectedRestaurant;
  bool showList = true;

  @override
  Widget build(BuildContext context) {
    bool singleScreen = MediaQuery.of(context).hinge == null && MediaQuery.of(context).size.width < 1000;
    var panePriority = TwoPanePriority.both;
    if (singleScreen) {
      panePriority = showList ? TwoPanePriority.start : TwoPanePriority.end;
    }

    Widget restaurantList = ListPane(
      restaurants: restaurants,
      selectedRestaurant: selectedRestaurant,
      singleScreen: singleScreen,
      onRestaurantTap: (index) {
        setState(() {
          this.selectedRestaurant = index;
        });
        if (index != null) {
          openRestaurant(context, restaurants[index]);
        }
      },
    );

    Widget restaurantMap = MapPane(
      restaurants: restaurants,
      selectedRestaurant: selectedRestaurant,
      onPinTap: (index) {
        setState(() {
          this.selectedRestaurant = index;
        });
      },
      onPopupTap: (index) => openRestaurant(context, restaurants[index]),
      singleScreen: singleScreen,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Dual View Restaurants'),
        actions: [
          if (singleScreen)
            TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                setState(() {
                  showList = !showList;
                });
              },
              child: Text(showList ? 'Map' : 'List'),
            )
        ],
      ),
      body: TwoPane(
        startPane: restaurantList,
        endPane: restaurantMap,
        panePriority: panePriority,
        paneProportion: 0.4,
        inset: EdgeInsets.only(top: kToolbarHeight + MediaQuery.of(context).padding.top),
      ),
    );
  }

  void openRestaurant(BuildContext context, Restaurant restaurant) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return RestaurantScreen(restaurant: restaurant);
      }),
    );
  }
}

/// Shows a list of restaurants.
///
/// Use [singleScreen] to let the widget know what if this is used alongside
/// a [MapPane] or not.
///   - If it is, then the selected pin is highlighted.
///   - If it is not, no highlighting is needed because selection is not
///   possible and does not make sense.
class ListPane extends StatefulWidget {
  final List<Restaurant> restaurants;
  final int? selectedRestaurant;
  final ValueChanged<int?> onRestaurantTap;
  final bool singleScreen;

  const ListPane({
    Key? key,
    required this.restaurants,
    required this.selectedRestaurant,
    required this.onRestaurantTap,
    required this.singleScreen,
  }) : super(key: key);

  @override
  _ListPaneState createState() => _ListPaneState();
}

class _ListPaneState extends State<ListPane> {
  late ScrollController scrollController;
  static const itemHeight = 125.0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
        initialScrollOffset: (widget.selectedRestaurant ?? 0.0) * itemHeight);
  }

  @override
  void didUpdateWidget(covariant ListPane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedRestaurant != null &&
        oldWidget.selectedRestaurant != widget.selectedRestaurant) {
      scrollController.animateTo(
        widget.selectedRestaurant! * itemHeight,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemBuilder: (ctx, index) => SizedBox(
        height: itemHeight,
        child: RestaurantListItem(
          restaurant: widget.restaurants[index],
          selected: !widget.singleScreen && index == widget.selectedRestaurant,
          onTap: () {
            widget.onRestaurantTap(index);
          },
        ),
      ),
      itemCount: widget.restaurants.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 0.0),
    );
  }
}

/// Shows a map of restaurants.
///
/// Use [singleScreen] to let the widget know what if this is used alongside
/// a [ListPane] or not.
///  - If it is, then we rely on the list to show details about
///  the pin we selected.
///  - If it is not, then this widget needs a way to how details about the
///  selected pin and it does this by showing a small popup at the bottom.
class MapPane extends StatelessWidget {
  final List<Restaurant> restaurants;
  final int? selectedRestaurant;
  final ValueChanged<int?> onPinTap;
  final ValueChanged<int> onPopupTap;
  final bool singleScreen;

  const MapPane({
    Key? key,
    required this.restaurants,
    required this.selectedRestaurant,
    required this.onPinTap,
    required this.onPopupTap,
    required this.singleScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Restaurant? selectedMarker =
        selectedRestaurant == null ? null : restaurants[selectedRestaurant!];
    List<Restaurant> normalMarkers =
        restaurants.where((element) => element != selectedMarker).toList();

    return Stack(
      children: [
        Positioned.fill(
          child: FakeMap(
            markers: normalMarkers.map((e) => e.latLong).toList(),
            selectedMarker: selectedMarker?.latLong,
            onMarkerSelected: (index) {
              if (index == null) {
                onPinTap(null);
              } else {
                Restaurant newSelection = normalMarkers[index];
                onPinTap(restaurants.indexOf(newSelection));
              }
            },
          ),
        ),
        if (singleScreen && selectedMarker != null)
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: SizedBox(
                  height: 130,
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(16.0),
                    child: RestaurantListItem(
                        restaurant: selectedMarker,
                        onTap: () => onPopupTap(selectedRestaurant!)),
                  ),
                ),
              ))
      ],
    );
  }
}


