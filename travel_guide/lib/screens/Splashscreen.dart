import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // a screen with the logo at the middle that waits for 3 seconds and route to the main screen

    // show this page for 3 seconds then route to the main page
    Future.delayed(const Duration(seconds: 5), () {
      context.go('/home');
    });

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child:
                Image.asset('assets/images/Skateboard Astonaut Sticker.jfif'),
          ),
        ),
      ),
    );
  }
}
