import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/restaurant/restaurant.dart';
import '../../common/restaurant_card.dart';

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
