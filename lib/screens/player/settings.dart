import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_genshin_lyre/utils/widget_functions.dart';

Widget settings(BuildContext context, Function()? toggleMode) => Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: Theme.of(context).typography?.header),
          addVerticalSpace(10),
          Button(text: Text('Toggle Dark Mode'), onPressed: toggleMode)
        ],
      ),
    );
