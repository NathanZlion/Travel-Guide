import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/cart/cart.dart';
import '../../../application/restaurant/restaurant.dart';
import '../../../infrastructure/cart/api_provider.dart';
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
                      // Sideways scrollable list of images of the restaurant
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
                        onPressed: () async {
                          final cartBloc = BlocProvider.of<CartBloc>(context);
                          bool itemInCart =
                              await CartCache.checkItemInCart(restaurant);
                          if (itemInCart) {
                            cartBloc.add(CartRemove(item: restaurant));
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Removed item from cart'),
                              ),
                            );
                          } else {
                            cartBloc.add(CartAdd(item: restaurant));
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item added to cart'),
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is CartInitial) {
                              final cartBloc =
                                  BlocProvider.of<CartBloc>(context);
                              cartBloc.add(CartLoad());
                              return const Text('Add to cart',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.blue));
                            }
                            if (state is CartLoading) {
                              return const CircularProgressIndicator();
                            } else if (state is CartLoaded) {
                              bool itemInCart = state.cart.restaurants
                                  .any((item) => item.id == restaurant.id);
                              if (itemInCart) {
                                return const Text('Remove item from cart',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        backgroundColor: Colors.red,
                                        color: Colors.white));
                              } else {
                                return const Text('Add item to cart',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        backgroundColor: Colors.blue,
                                        color: Colors.white));
                              }
                            } else if (state is CartError) {
                              return Text(state.message);
                            } else {
                              return const Text("Unexpected error");
                            }
                          },
                        ),
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
