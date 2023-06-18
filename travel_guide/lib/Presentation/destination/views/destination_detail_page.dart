import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel_guide/infrastructure/cart/api_provider.dart';

import '../../../application/cart/cart.dart';
import '../../../application/destination/destination.dart';
import '../../screens_barrel.dart';

class DestinationDetailPage extends StatelessWidget {
  final String destinationId;

  const DestinationDetailPage(this.destinationId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DestinationBloc()..add(DestinationDetailLoadEvent(destinationId)),
      child: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<DestinationBloc>(context)
              .add(DestinationDetailLoadEvent(destinationId));

          // a snackbar to show the user that the data is being refreshed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Refreshing data...'),
            ),
          );
          return Future.delayed(const Duration(seconds: 1));
        },
        child: BlocBuilder<DestinationBloc, DestinationState>(
          builder: (context, state) {
            if (state is DestinationDetailLoading) {
              return Scaffold(
                appBar: AppBar(
                  leading: const BackButton(),
                  title: const Text('Destination Detail'),
                ),
                body: const LoadingScreen(),
              );
            }
            // loaded successfully
            else if (state is DestinationDetailLoaded) {
              final Destination destination = state.destination;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Destination Detail'),
                ),
                body: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      Image.network(
                        destination.image,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          destination.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          destination.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: RatingBar.builder(
                            initialRating: destination.rating,
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
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Things to do:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        children: destination.thingsToDo.map((thing) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListTile(
                              leading: const Icon(Icons.check),
                              title: Text(thing),
                            ),
                          );
                        }).toList(),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final cartBloc = BlocProvider.of<CartBloc>(context);
                          bool itemInCart =
                              await CartCache.checkItemInCart(destination);
                          if (itemInCart) {
                            cartBloc.add(CartRemove(item: destination));
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Removed item from cart'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            cartBloc.add(CartAdd(item: destination));
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
                            if (state is CartInitial) {
                              final cartBloc =
                                  BlocProvider.of<CartBloc>(context);
                              cartBloc.add(CartLoad());
                              return const Text('Add to cart',style: TextStyle(fontSize: 16.0, color: Colors.blue));
                            }
                            if (state is CartLoading) {
                              return const CircularProgressIndicator();
                            } else if (state is CartLoaded) {
                              bool itemInCart = state.cart.destinations
                                  .any((item) => item.id == destination.id);
                              if (itemInCart) {
                                return const Text('Remove item from cart',
                                    style: TextStyle(
                                        fontSize: 16.0,
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
                    ])),
              );
            } else if (state is DestinationDetailError) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Destination Detail'),
                  ),
                  body: Center(
                      // Display an error message with a reload button
                      child: TextButton(
                          onPressed: () {
                            BlocProvider.of<DestinationBloc>(context)
                                .add(DestinationDetailLoadEvent(destinationId));
                          },
                          child: const Text("Reload"))));
            } else {
              // Add the load destination detail event to the bloc
              BlocProvider.of<DestinationBloc>(context)
                  .add(DestinationDetailLoadEvent(destinationId));
              return Scaffold(
                  appBar: AppBar(title: const Text('Destination Detail')),
                  body: const LoadingScreen());
            }
          },
        ),
      ),
    );
  }
}
