import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement add to cart functionality
                            // In fact, check if already in cart and conditionally have a remove from cart button

                            
                          },
                          child: const Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    child: const Text("Reload"),
                  ),
                ),
              );
            } else {
              // Add the load destination detail event to the bloc
              BlocProvider.of<DestinationBloc>(context)
                  .add(DestinationDetailLoadEvent(destinationId));
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Destination Detail'),
                ),
                body: const LoadingScreen(),
              );
            }
          },
        ),
      ),
    );
  }
}
