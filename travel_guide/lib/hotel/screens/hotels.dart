import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/hotel.model.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<StatefulWidget> createState() => HotelsPageState();
}

class HotelsPageState extends State<HotelPage> {
  List<Hotel> hotels = [];
  Icon visibleIcon = const Icon(Icons.search);

  fetchHotels() async {
    // fetch popular hotels from some api
    // then set the state of the hotels list
  }

  searchHotels(String query) async {
    // search hotels from some api
    // then set the state of the hotels list
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // an appbar that backButton, shows title of page, and search icon
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pop(),
          ),
          title: const Text("Hotels"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              // On pressed make the search bar visible and on search bar clicked make it invisible and show the search results
              onPressed: () {},
            )
          ],
        ),

        // show a list of hotels with their names and images and a button to view the hotel details
        body: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(hotels[index].name),
              leading: Image(
                image: NetworkImage(hotels[index].image),
                fit: BoxFit.cover,
              ),
              subtitle: Text(hotels[index].description),
              trailing: ElevatedButton(
                onPressed: () => context.push('/hotel/details'),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        ),
      ),
    );
  }
}
