import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String themeModeKey = 'theme_mode';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    // When the provider is created, load the saved theme preference
    _loadThemeMode();
  }

  // Reads the saved theme from the device's storage
  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(themeModeKey);
    if (savedTheme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (savedTheme == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
    // Notify listeners after loading the theme so the app starts with the right theme
    notifyListeners();
  }

  // This is the method called by your settings page switch
  void setTheme(bool isDarkMode) async {
    if (isDarkMode) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    
    // --- FIX: Notify listeners immediately for an instant UI update ---
    notifyListeners();

    // Now, save the preference in the background without making the UI wait
    final prefs = await SharedPreferences.getInstance();
    if (isDarkMode) {
      await prefs.setString(themeModeKey, 'dark');
    } else {
      await prefs.setString(themeModeKey, 'light');
    }
  }
}

