import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/cart/cart.dart';
import '../../../application/hotel/hotel.dart';
import '../../../infrastructure/cart/api_provider.dart';
import '../../screens_barrel.dart';

class HotelDetailPage extends StatelessWidget {
  final String hotelId;

  const HotelDetailPage(this.hotelId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelBloc()..add(HotelDetailLoadEvent(hotelId)),
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<HotelBloc>(context)
              .add(HotelDetailLoadEvent(hotelId));

          // a snackbar to show the user that the data is being refreshed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Refreshing data...'),
            ),
          );
          return Future.delayed(const Duration(seconds: 5));
        },
        child: BlocBuilder<HotelBloc, HotelState>(
          builder: (context, state) {
            if (state is HotelDetailLoading) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Hotel Detail'),
                ),
                body: const LoadingScreen(),
              );
            }
            // hotel list is loaded
            else if (state is HotelDetailLoaded) {
              final Hotel hotel = state.hotel;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Hotel Detail'),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [

                      // Hotel name
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          hotel.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Hotel image
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.network(
                          hotel.image,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          hotel.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final cartBloc = BlocProvider.of<CartBloc>(context);
                          bool itemInCart =
                              await CartCache.checkItemInCart(hotel);
                          if (itemInCart) {
                            cartBloc.add(CartRemove(item: hotel));
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Removed item from cart'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            cartBloc.add(CartAdd(item: hotel));
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item added to cart'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is CartInitial){
                              final cartBloc = BlocProvider.of<CartBloc>(context);
                              cartBloc.add(CartLoad());
                              return const Text('Add to cart',
                                  style: TextStyle(fontSize: 16.0, color: Colors.blue));
                            }
                            if (state is CartLoading) {
                              return const CircularProgressIndicator();
                            } else if (state is CartLoaded) {
                              bool itemInCart = state.cart.hotels.any((item) => item.id == hotel.id);
                              if (itemInCart) {
                                return const Text('Remove item from cart',
                                    style: TextStyle(fontSize: 16.0, backgroundColor: Colors.red, color: Colors.white));
                              } else {
                                return const Text('Add item to cart',
                                    style: TextStyle(fontSize: 16.0, backgroundColor: Colors.blue, color: Colors.white));
                              }
                            } else if (state is CartError) {
                              return Text(state.message);
                            } else {
                              return const Text("Unexpected error");
                            }
                          },
                        ),
                      ),                    ],
                  ),
                ),
              );
            } else if (state is HotelDetailError) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Hotel Detail'),
                ),
                body: const Center(
                  child: Text('Failed to load hotel detail.'),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Hotel Detail'),
                ),
                body: Container(),
              );
            }
          },
        ),
      ),
    );
  }
}
