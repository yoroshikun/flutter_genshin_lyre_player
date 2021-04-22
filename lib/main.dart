import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models/theme.dart';
import 'screens/main.dart';
import 'screens/welcome.dart';

void main() {
  // License for manrope google font
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final model = useProvider(themeProvider);

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
        'main': (context) => MainScreen()
      },
      home: WelcomeScreen(),
    );
  }
}
