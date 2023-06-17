import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/hotel/hotel.dart';
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
            } else if (state is HotelDetailLoaded) {
              final Hotel hotel = state.hotel;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Hotel Detail'),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          hotel.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implement add to cart functionality
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ],
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
