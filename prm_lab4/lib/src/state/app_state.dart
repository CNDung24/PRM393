import 'package:flutter/material.dart';

/// App-level state for Exercise 4 (ThemeData + Dark Mode via themeMode).
///
/// Note: We keep this as a ChangeNotifier so the UI can remain Stateless.
class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setDarkMode(bool isDark) {
    final next = isDark ? ThemeMode.dark : ThemeMode.light;
    if (next == _themeMode) return;
    _themeMode = next;
    notifyListeners();
  }
}

/// State for Exercise 2 input controls.
///
/// This replaces the need for a custom StatefulWidget.
class InputDemoState extends ChangeNotifier {
  double _sliderValue = 40;
  bool _notificationsEnabled = true;
  String _selectedLevel = 'Beginner';
  DateTime? _selectedDate;

  double get sliderValue => _sliderValue;
  bool get notificationsEnabled => _notificationsEnabled;
  String get selectedLevel => _selectedLevel;
  DateTime? get selectedDate => _selectedDate;

  void setSliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  void setNotificationsEnabled(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void setSelectedLevel(String value) {
    _selectedLevel = value;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
    );

    if (picked != null) {
      _selectedDate = picked;
      notifyListeners();
    }
  }
}