import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/Presentation/common/stylish_bottom_nav.dart';

import '../../application/Theme/bloc/theme_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    routeTo(String dest) {
      context.push('/$dest');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeBloc>().state.theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Travel Guide",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SizedBox(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/Skateboard Astonaut Sticker.jfif', // Replace with your image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(height: 30),
                    SizedBox(
                      height: 350,
                      child: ListView(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.hotel),
                            title: const Text("Hotels",
                                style: TextStyle(fontSize: 18)),
                            subtitle: const Text("Hotels to stay in.",
                                style: TextStyle(fontSize: 14)),
                            trailing: const Icon(Icons.arrow_forward_rounded),
                            onTap: () => routeTo("hotels"),
                            focusColor: Colors.blue,
                          ),
                          Container(height: 40),
                          ListTile(
                            leading: const Icon(Icons.restaurant),
                            title: const Text("Restaurants",
                                style: TextStyle(fontSize: 18)),
                            subtitle: const Text("Restaurants just for you",
                                style: TextStyle(fontSize: 14)),
                            trailing: const Icon(Icons.arrow_forward_rounded),
                            onTap: () => routeTo("restaurants"),
                            focusColor: Colors.blue,
                          ),
                          Container(height: 40),
                          ListTile(
                            leading: const Icon(Icons.hotel),
                            title: const Text("Destinations",
                                style: TextStyle(fontSize: 18)),
                            subtitle: const Text("Cool places to visit.",
                                style: TextStyle(fontSize: 14)),
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
        ),
        bottomNavigationBar: StylishBottomNavigation(selectedIndex: 0),
      ),
    );
  }
}


