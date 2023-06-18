import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'Presentation/cart/cart_list.dart';
import './Presentation/screens_barrel.dart';
import 'Presentation/common/settings.dart';
import 'application/cart/cart.dart';
import 'application/destination/destination.dart';
import 'application/hotel/hotel.dart';
import 'application/Theme/theme.dart';
import 'application/restaurant/restaurant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'serviceLocator.dart';

// import 'local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  ServiceLocator().registerPreferences(preferences);
  await dotenv.load();
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
        path: '/Settings',
        builder: (context, state) => const Settings(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartList(),
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
          BlocProvider(create: (context) => CartBloc()),
          BlocProvider(create: (context) => ThemeBloc()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Travel Guide',
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
        ));
  }
}
