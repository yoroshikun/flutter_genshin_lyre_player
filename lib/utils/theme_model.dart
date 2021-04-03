import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel with ChangeNotifier {
  late ThemeMode _mode;
  ThemeMode get mode => _mode;
  // ThemeModel({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  ThemeModel() {
    SharedPreferences.getInstance().then((prefs) {
      final bool darkMode = prefs.getBool('darkMode') ?? false;
      if (darkMode) {
        _mode = ThemeMode.dark;
      } else {
        _mode = ThemeMode.light;
      }
      notifyListeners();
    });

    _mode = ThemeMode.light;
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
