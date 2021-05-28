import 'package:dual_screen_samples/dual_view_restaurants/data.dart';
import 'package:flutter/material.dart';

/// Shows a summary of a restaurant.
///
/// This is used to render items in the Restaurant List pane but is also used
/// to show details about the selected pin on the Restaurant Map pane in
/// single-screen mode.
class RestaurantListItem extends StatelessWidget {
  final Restaurant restaurant;
  final bool selected;
  final VoidCallback? onTap;

  const RestaurantListItem({
    Key? key,
    required this.restaurant,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final price = List.generate(restaurant.priceRange, (index) => '\$').join();
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Image.asset(
              restaurant.picture,
              width: 140,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      restaurant.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(width: 6),
                    Rating(rating: restaurant.rating),
                    SizedBox(width: 6),
                    Text(
                      '(${restaurant.voteCount})',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  '${restaurant.type} • $price',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 14),
                Text(
                  '✓ Open now',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.lightGreen[800]),
                ),
              ],
            ),
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (selected)
                  Icon(
                    Icons.location_pin,
                    color: Colors.red[800]!,
                    size: 32,
                  ),
                Text(
                  '${restaurant.rating.ceil()} min away',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Simulates a map plugin.
///
/// A real map implementation would require API keys or other configuration and
/// this sample needs to be simple and require no configuration from developers.
/// Implementation details are not relevant to the sample.
class FakeMap extends StatelessWidget {
  final List<LatLong> markers;
  final LatLong? selectedMarker;
  final ValueChanged<int?> onMarkerSelected;

  const FakeMap({
    Key? key,
    this.markers = const [],
    this.selectedMarker,
    required this.onMarkerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              onMarkerSelected.call(null);
            },
            child: Image.asset(
              'images/dual_view_restaurants/city_map.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        ...markers.map(
              (e) => Positioned(
            left: e.lat,
            top: e.long,
            child: GestureDetector(
              onTap: () {
                onMarkerSelected.call(markers.indexOf(e));
              },
              child: Container(
                decoration:
                ShapeDecoration(shape: CircleBorder(), color: Colors.white),
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.restaurant,
                  color: Colors.deepOrange,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
        if (selectedMarker != null)
          Positioned(
            left: selectedMarker!.lat,
            top: selectedMarker!.long - 14,
            child: Icon(
              Icons.location_pin,
              color: Colors.red[800]!,
              size: 32,
            ),
          ),
      ],
    );
  }
}

/// A separate screen for one restaurant.
///
/// In this screen the user can order food or start directions or otherwise
/// interact with the restaurant.
class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final price = List.generate(restaurant.priceRange, (index) => '\$').join();
    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: TwoPane(
        pane1: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      restaurant.picture,
                      height: 140,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: GenericBox(height: 134, width: 134),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: GenericBox(height: 134),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      restaurant.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(width: 6),
                    Rating(rating: restaurant.rating),
                    SizedBox(width: 6),
                    Text(
                      '(${restaurant.voteCount})',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Expanded(child: Container()),
                    Text(
                      '✓ Open now',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.lightGreen[800]),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  '${restaurant.type} • $price',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 12),
                GenericBox(height: 14, width: double.infinity),
                SizedBox(height: 12),
                GenericBox(height: 14, width: double.infinity),
                SizedBox(height: 12),
                GenericBox(height: 14, width: double.infinity),
                SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                        child: GenericBox(height: 100, width: double.infinity)),
                    SizedBox(width: 12),
                    Expanded(
                        child: GenericBox(height: 100, width: double.infinity)),
                  ],
                ),
                SizedBox(height: 12),
                GenericBox(height: 14, width: double.infinity),
                SizedBox(height: 12),
                GenericBox(height: 150, width: double.infinity),
              ],
            ),
          ),
        ),
        pane2: Stack(
          children: [
            Positioned.fill(child: Image.asset('images/dual_view_restaurants/city_map.png', fit: BoxFit.cover)),
            Center(
              child: Icon(
                Icons.location_pin,
                color: Colors.red[800]!,
                size: 32,
              ),
            )
          ],
        ),
        panePriority: MediaQuery.of(context).hinge == null
            ? TwoPanePriority.pane1
            : TwoPanePriority.both,
      ),
    );
  }
}

/// Grey box used to fill the screen with temporary content.
class GenericBox extends StatelessWidget {
  final double? width, height;

  const GenericBox({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(16)),
    );
  }
}

/// Shows a 5-star rating.
class Rating extends StatelessWidget {
  final double rating;
  static const int maxRating = 5;

  const Rating({Key? key, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.yellow[700]!, Colors.yellow[700]!, Colors.grey],
          stops: [0.0, rating / maxRating, rating / maxRating])
          .createShader(bounds),
      child: Row(
        children:
        List.generate(maxRating, (index) => Icon(Icons.star, size: 14)),
      ),
    );
  }
}