import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/restaurant/restaurant.dart';
import '../../screens_barrel.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailPage(this.restaurantId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantBloc(),
      child: RefreshIndicator(
        onRefresh: () async {
          context
              .read<RestaurantBloc>()
              .add(RestaurantDetailLoadEvent(restaurantId));

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Restaurant detail refreshed'),
            ),
          );

          return Future.delayed(const Duration(seconds: 1));
        },
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantInitial) {
              context
                  .read<RestaurantBloc>()
                  .add(RestaurantDetailLoadEvent(restaurantId));
              return const LoadingScreen();
            } else if (state is RestaurantDetailLoading) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Restaurant Detail'),
                ),
                body: const LoadingScreen(),
              );
            } else if (state is RestaurantDetailLoaded) {
              final Restaurant restaurant = state.restaurant;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Restaurant Detail'),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          restaurant.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // make a sideways scrollable list of images
                      SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: restaurant.images.length,
                          itemBuilder: (context, index) {
                            final image = restaurant.images[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          restaurant.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add to cart logic
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is RestaurantDetailError) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Restaurant Detail'),
                ),
                body: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(title: const Text('Restaurant Detail')),
                body: Text('state: $state)'),
              );
            }
          },
        ),
      ),
    );
  }
}
