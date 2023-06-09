import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    routeTo(String dest) {
      context.push('/$dest');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Travel Guide",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          actions: [
            IconButton(
              color: Colors.black,
              onPressed: () {
                routeTo("cart");
              },
              icon: const Icon(Icons.card_travel),
            ),
            IconButton(
              color: Colors.black,
              onPressed: () {
                routeTo("settings");
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: SizedBox(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the value as per your requirement
                      child: Image.asset(
                        'assets/images/Skateboard Astonaut Sticker.jfif', // Replace with your image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                    // SizedBox(
                    //     height: 400,
                    //     child: Image.asset(
                    //         "assets/images/Skateboard Astonaut Sticker.jfif")),
                    Container(height: 30),
                    SizedBox(
                      height: 500,
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
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
                          // Container(height: 10),
                          // const Divider(),
                          // Container(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
