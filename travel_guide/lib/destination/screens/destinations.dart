import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DestinationsPage extends StatelessWidget {
  const DestinationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(children: [
        const Text("The Destinations page"),
        ElevatedButton(
            onPressed: () => context.pop(),
            child: const Icon(Icons.arrow_back_ios))
      ]),
    ));
  }
}
