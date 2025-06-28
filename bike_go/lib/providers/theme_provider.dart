import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance(); 
    _isDarkMode = prefs.getBool('dark_mode_enabled') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    
    final prefs = await SharedPreferences.getInstance(); 
    await prefs.setBool('dark_mode_enabled', _isDarkMode);
    
    notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  // Light theme
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF22C55E),
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF6B7280)),
      titleTextStyle: TextStyle(
        color: Color(0xFF1F2937),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF22C55E),
      secondary: Color(0xFF3B82F6),
      surface: Colors.white,
      error: Color(0xFFEF4444),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF1F2937),
      onError: Colors.white,
    ),
  );

  // Dark theme
  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF22C55E),
    scaffoldBackgroundColor: const Color(0xFF1F2937),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF111827),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFE5E7EB)),
      titleTextStyle: TextStyle(
        color: Color(0xFFF9FAFB),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF22C55E),
      secondary: Color(0xFF3B82F6),
      surface: Color(0xFF111827),
      error: Color(0xFFEF4444),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFFF9FAFB),
      onError: Colors.white,
    ),
  );


}



