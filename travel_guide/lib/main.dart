import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/screens/Splashscreen.dart';
import 'package:travel_guide/screens/destinations.dart';
import 'package:travel_guide/screens/homePage.dart';
import 'package:travel_guide/screens/hotels.dart';
import 'package:travel_guide/screens/restaurants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    /**

    A list of possible routes in our application.
          `/entry`               => point shows splash screen
          `/home`                => shows home page
          `/destinations`        => shows destinations page
          `/destination/details` => shows destination details page
          `/restaurants`         => shows restaurants page
          `/restaurant/details   => shows restaurant details page
          `/hotels`              => shows hotels page
          `/hotel/details`       => shows hotel details page
          `/profile`             => profile page
          `/cart`                => shows cart page this is where the user can store all the places he wants to visit
          `/settings`            => to show settings
     */

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/destinations',
        builder: (context, state) => const DestinationsPage(),
      ),
      GoRoute(
        path: '/destination/details',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/restaurants',
        builder: (context, state) => const RestaurantsPage(),
      ),
      GoRoute(
        path: '/restaurant/details',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/hotels',
        builder: (context, state) => const HotelsPage(),
      ),
      GoRoute(
        path: '/hotel/details',
        builder: (context, state) => const HomePage(),
      ),
      // destination search
      GoRoute(
        path: '/destination/search',
        builder: (context, state) => const HomePage(),
      ),
      // restaurant search
      GoRoute(
        path: '/restaurant/search',
        builder: (context, state) => const HomePage(),
      ),
      // hotel search
      GoRoute(
        path: '/hotel/search',
        builder: (context, state) => const HomePage(),
      ),
      // profile
      GoRoute(
        path: '/About',
        builder: (context, state) => const HomePage(),
      ),
      // planning the trip using the cart
      GoRoute(
        path: '/cart',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}
