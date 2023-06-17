import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/hotel/hotel.dart';
import '../../common/hotel_card.dart';

class HotelsListPage extends StatefulWidget {
  const HotelsListPage({Key? key}) : super(key: key);

  @override
  HotelsListPageState createState() => HotelsListPageState();
}

class HotelsListPageState extends State<HotelsListPage> {
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
        title: const Text('Hotels List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Hotel Name',
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
                    context.read<HotelBloc>().add(
                          HotelListLoadEvent(location, name),
                        );
                  },
                  child: const Text('Search'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _nameController.clear();
                    _locationController.clear();
                    context.read<HotelBloc>().add(
                          const HotelListLoadEvent('', ''),
                        );
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: BlocBuilder<HotelBloc, HotelState>(
                builder: (context, state) {
                  if (state is HotelInitial) {
                    context
                        .read<HotelBloc>()
                        .add(const HotelListLoadEvent('', ''));
                  } else if (state is HotelListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HotelListError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is HotelListEmpty) {
                    return const Center(child: Text('No hotels found'));
                  } else if (state is HotelListLoaded) {
                    return ListView.builder(
                      itemCount: state.hotels.length,
                      itemBuilder: (context, index) {
                        final hotel = state.hotels[index];
                        return HotelCard(hotel: hotel);
                      },
                    );
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
