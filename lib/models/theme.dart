import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Exampel of non freezed change notifier
class Theme with ChangeNotifier {
  late ThemeMode _mode;
  ThemeMode get mode => _mode;

  Theme() {
    final brightness = SchedulerBinding.instance?.window.platformBrightness;

    SharedPreferences.getInstance().then((prefs) {
      final bool darkMode =
          prefs.getBool('darkMode') ?? brightness == Brightness.dark;

      if (darkMode) {
        _mode = ThemeMode.dark;
      } else {
        _mode = ThemeMode.light;
      }
      notifyListeners();
    });

    _mode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    SharedPreferences.getInstance().then((prefs) {
      if (_mode == ThemeMode.light) {
        prefs.setBool('darkMode', false);
      } else {
        prefs.setBool('darkMode', true);
      }
    });
    notifyListeners();
  }
}

final themeProvider = ChangeNotifierProvider((ref) => Theme());
