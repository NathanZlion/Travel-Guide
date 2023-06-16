import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import './Presentation/screens_barrel.dart';
import 'application/destination/destination.dart';
import 'application/hotel/hotel.dart';
import 'application/restaurant/restaurant.dart';
import 'local_storage.dart';

Future<void> main() async {
  SQLHelper.openDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
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
        builder: (context, state) => const DestinationsListPage(),
      ),
      GoRoute(
        path: '/destination/:id',
        builder: (context, state) => DestinationDetailPage(
          state.params['id']!,
        ),
      ),
      GoRoute(
        path: '/restaurants',
        builder: (context, state) => const RestaurantsListPage(),
      ),
      GoRoute(
        path: '/restaurant/:id',
        builder: (context, state) => RestaurantDetailPage(
          state.params['id']!,
        ),
      ),
      GoRoute(
        path: '/hotels',
        builder: (context, state) => const HotelsListPage(),
      ),
      GoRoute(
        path: '/hotel/:id',
        builder: (context, state) => HotelDetailPage(
          state.params['id']!,
        ),
      ),
      GoRoute(
        path: '/About',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // bloc providers for the app.
        providers: [
          BlocProvider(create: (context) => DestinationBloc()),
          BlocProvider(create: (context) => RestaurantBloc()),
          BlocProvider(create: (context) => HotelBloc()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Travel Guide',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
        ));
  }
}
