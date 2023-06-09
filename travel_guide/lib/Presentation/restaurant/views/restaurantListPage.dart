import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../application/restaurant/restaurant.dart';

class RestaurantsListPage extends StatefulWidget {
  const RestaurantsListPage({Key? key}) : super(key: key);

  @override
  RestaurantsListPageState createState() => RestaurantsListPageState();
}

class RestaurantsListPageState extends State<RestaurantsListPage> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Restaurant Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final String name = _nameController.text;
                    final String location = _locationController.text;
                    context.read<RestaurantBloc>().add(
                          RestaurantListLoadEvent(name, location),
                        );
                  },
                  child: const Text('Search'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _nameController.clear();
                    _locationController.clear();
                    context
                        .read<RestaurantBloc>()
                        .add(const RestaurantListLoadEvent('', ''));
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: BlocBuilder<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantInitial) {
                    context
                        .read<RestaurantBloc>()
                        .add(const RestaurantListLoadEvent('', ''));
                    return const Center(child: Text(''));
                  } else if (state is RestaurantListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RestaurantListError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is RestaurantListEmpty) {
                    return const Center(child: Text('No destinations found'));
                  } else if (state is RestaurantListLoaded) {
                    // displaying the list of destinations
                    print(state.restaurants);
                    return ListView.builder(
                        itemCount: state.restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = state.restaurants[index];
                          return RestaurantCard(restaurant: restaurant);
                        });
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          context.push('/restaurant/${restaurant.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // first image if exists
            if (restaurant.images.isNotEmpty)
              Image.network(
                restaurant.images[0],
                height: 150.0,
                fit: BoxFit.cover,
              ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                restaurant.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.location_on, size: 16.0),
                ),
                Text(restaurant.location),
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RatingBar.builder(
                      initialRating: restaurant.rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // do nothing
                      },
                    )),
                Text(restaurant.rating.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
