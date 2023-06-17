import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/application/hotel/hotel.dart';
import 'package:travel_guide/application/restaurant/model/restaurant_model.dart';

import '../../application/cart/cart.dart';
import '../../application/destination/destination.dart';
import '../common/destination_card.dart';
import '../common/hotel_card.dart';
import '../common/restaurant_card.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartInitial) {
                context.read<CartBloc>().add(CartLoad());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is CartError) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state is CartLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      RestaurantsInCartListView(
                          restaurants: state.cart.restaurants),
                      const SizedBox(height: 8),
                      HotelsInCartListView(hotels: state.cart.hotels),
                      const SizedBox(height: 8),
                      DestinationsInCartListView(
                          destinations: state.cart.destinations),
                    ],
                  ),
                );
              }

              return const Center(
                child: Text('Something went wrong!'),
              );
            },
          ),
        ));
  }
}

class DestinationsInCartListView extends StatelessWidget {
  final List<Destination> destinations;
  const DestinationsInCartListView({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Destinations', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: destinations.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      final item = destinations[index];

                      return Row(
                        children: [
                          Expanded(child: DestinationCard(destination: item)),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(CartRemove(item: item));
                            },
                            icon: const Icon(Icons.remove_circle),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).push('/destinations');
                      },
                      child:
                          const Text('No Destinations in Cart, Explore some!'),
                    ),
                  )),
      ],
    );
  }
}

class RestaurantsInCartListView extends StatelessWidget {
  final List<Restaurant> restaurants;
  const RestaurantsInCartListView({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Restaurants', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: restaurants.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final item = restaurants[index];

                      return Row(
                        children: [
                          Expanded(child: RestaurantCard(restaurant: item)),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(CartRemove(item: item));
                            },
                            icon: const Icon(Icons.remove_circle),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).push('/restaurants');
                      },
                      child:
                          const Text('No Restaurants in Cart, Explore some!'),
                    ),
                  )),
      ],
    );
  }
}

class HotelsInCartListView extends StatelessWidget {
  final List<Hotel> hotels;
  const HotelsInCartListView({super.key, required this.hotels});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Hotel', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: hotels.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      final item = hotels[index];

                      return Row(
                        children: [
                          Expanded(child: HotelCard(hotel: item)),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(CartRemove(item: item));
                            },
                            icon: const Icon(Icons.remove_circle),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).push('/hotels');
                      },
                      child: const Text('No Hotels in Cart, Explore some!'),
                    ),
                  )),
      ],
    );
  }
}

