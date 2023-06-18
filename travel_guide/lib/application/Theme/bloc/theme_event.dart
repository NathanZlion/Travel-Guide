
abstract class ThemeEvent {}

class ThemeChangedEvent extends ThemeEvent {
  final bool isDarkThemeOn;

  ThemeChangedEvent({required this.isDarkThemeOn});
}
