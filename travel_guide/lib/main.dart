import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/screens/Splashscreen.dart';
import 'package:travel_guide/destination/screens/destinations.dart';
import 'package:travel_guide/screens/homePage.dart';
import 'package:travel_guide/hotel/screens/hotels.dart';
import 'package:travel_guide/restaurant/screens/restaurants.dart';

import 'destination/bloc/destination_bloc.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
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
        builder: (context, state) => const HotelPage(),
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DestinationBloc()),
          BlocProvider(create: (context) => RestaurantBloc()),
          BlocProvider(create: (context) => HotelBloc()),
        ],
        child: MaterialApp.router(
          title: 'Travel Guide',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
        ));
  }
}
