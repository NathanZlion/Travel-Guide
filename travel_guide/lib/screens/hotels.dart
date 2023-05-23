import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(children: [
        const Text("The Hotels page"),
        ElevatedButton(onPressed: () => context.pop(), child: const Icon(Icons.arrow_back_ios))
      ]),
    ));
  }
}
