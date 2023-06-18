import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeData theme;

  const ThemeState({required this.theme});

  @override
  List<Object> get props => [theme];
}

class DarkTheme extends ThemeState {
  DarkTheme()
      : super(
            theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: const Color.fromARGB(255, 5, 10, 13),
        ));
}

class LightTheme extends ThemeState {
  LightTheme()
      : super(
            theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
        ));
}
