import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:provider/provider.dart';

import 'screens/main.dart';
import 'screens/welcome.dart';
import 'utils/theme_model.dart';

void main() {
  // License for manrope google font
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (_, model, __) {
          return FluentApp(
            title: 'Genshin Auto Lyre',
            style: Style(
              brightness: Brightness.light,
            ),
            darkStyle: Style(
              brightness: Brightness.dark, /* typography: textThemeDefault */
            ),
            themeMode: model.mode,
            routes: {
              'welcome': (context) => WelcomeScreen(),
              'main': (context) => MainScreen(
                  title: 'Genshin Auto Lyre',
                  theme: model.mode,
                  toggleMode: model.toggleMode),
            },
            home: WelcomeScreen(),
          );
        },
      ),
    );
  }
}
