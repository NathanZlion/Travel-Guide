import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../application/destination/destination.dart';

class DestinationsListPage extends StatefulWidget {
  const DestinationsListPage({Key? key}) : super(key: key);

  @override
  DestinationsListPageState createState() => DestinationsListPageState();
}

class DestinationsListPageState extends State<DestinationsListPage> {
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
        title: const Text('Destinations List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Destination Name',
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
                    context.read<DestinationBloc>().add(
                          DestinationListLoadEvent(name, location),
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
                        .read<DestinationBloc>()
                        .add(const DestinationListLoadEvent('', ''));
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: BlocBuilder<DestinationBloc, DestinationState>(
                builder: (context, state) {
                  if (state is DestinationInitial) {
                    context
                        .read<DestinationBloc>()
                        .add(const DestinationListLoadEvent('', ''));
                    return const Center(child: Text(''));
                  } else if (state is DestinationListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DestinationListError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is DestinationListEmpty) {
                    return const Center(child: Text('No destinations found'));
                  } else if (state is DestinationListLoaded) {
                    // displaying the list of destinations
                    return ListView.builder(
                        itemCount: state.destinations.length,
                        itemBuilder: (context, index) {
                          final destination = state.destinations[index];
                          return DestinationCard(destination: destination);
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

class DestinationCard extends StatelessWidget {
  const DestinationCard({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          context.push('/destination/${destination.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
              child: Image.network(
                destination.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                destination.name,
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
                Text(destination.location),
              ],
            ),
            Row(
              children: [
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
                Text(destination.rating.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
