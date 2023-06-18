import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../serviceLocator.dart';
import '../theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  SharedPreferences preferences = ServiceLocator().preferences;

  ThemeBloc() : super(LightTheme()) {
    on<ThemeChangedEvent>((event, emit) {
      if (event.isDarkThemeOn) {
        preferences.setBool("isDarkThemeOn", true);
        // save the dark theme on to the shared preference
        emit(DarkTheme());
      } else {
        preferences.setBool("isDarkThemeOn", false);
        emit(LightTheme());
      }
    });
  }
}
