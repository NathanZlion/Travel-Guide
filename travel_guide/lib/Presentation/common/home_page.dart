import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/Presentation/common/stylish_bottom_nav.dart';

import '../../application/Theme/bloc/theme_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    routeTo(String dest) {
      context.push('/$dest');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Travel Guide",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/images/Skateboard Astonaut Sticker.jfif', // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 350,
                child: ListView(
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling within the ListView
                  children: [
                    ListTile(
                      leading: const Icon(Icons.hotel),
                      title: const Text(
                        "Hotels",
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: const Text(
                        "Hotels to stay in.",
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                      onTap: () => routeTo("hotels"),
                      focusColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.restaurant),
                      title: const Text(
                        "Restaurants",
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: const Text(
                        "Restaurants just for you",
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                      onTap: () => routeTo("restaurants"),
                      focusColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.hotel),
                      title: const Text(
                        "Destinations",
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: const Text(
                        "Cool places to visit.",
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                      onTap: () => routeTo("destinations"),
                      focusColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StylishBottomNavigation(selectedIndex: 0),
    );
  }
}
