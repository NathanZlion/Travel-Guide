import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/Presentation/common/stylish_bottom_nav.dart';
import 'package:travel_guide/application/cart/cart.dart';
import '../../application/Theme/theme.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: MaterialApp(
        theme: context.watch<ThemeBloc>().state.theme,
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              create: (context) => ThemeBloc(),
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView(
                    children: [
                      // a dark mode toggler
                      ListTile(
                        title: const Text('Dark Mode'),
                        trailing: Switch(
                          value: context.watch<ThemeBloc>().state is DarkTheme,
                          onChanged: (bool value) {
                            context
                                .read<ThemeBloc>()
                                .add(ThemeChangedEvent(isDarkThemeOn: value));
                          },
                        ),
                      ),

                      // A settings for editing profile
                      ListTile(
                        title: const Text('Clear Cart'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Clear Cart'),
                                content: const Text(
                                    'Are you sure you want to clear the cart?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      CartBloc().add(ClearCartEvent());
                                    },
                                    child: const Text('Clear'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: StylishBottomNavigation(selectedIndex: 2),
          ),
        ),
      ),
    );
  }
}
