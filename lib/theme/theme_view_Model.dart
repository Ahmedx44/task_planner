import 'package:stacked/stacked.dart';

class ThemeViewModel extends BaseViewModel {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkLightTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // This will notify listeners when the theme changes
  }
}
