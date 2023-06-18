import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/Theme/theme.dart';
import '../../../application/destination/destination.dart';
import '../../common/destination_card.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeBloc>().state.theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Destinations List'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
      ),
    );
  }
}
