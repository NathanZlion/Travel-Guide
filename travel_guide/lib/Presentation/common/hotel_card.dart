import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../application/hotel/hotel.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          context.push('/hotel/${hotel.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              constraints: const BoxConstraints(
                  maxHeight: 200.0), // Set the maximum height here
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
                child: Image.network(
                  hotel.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hotel.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                  Text(
                    hotel.location,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hotel.description,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis, fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
