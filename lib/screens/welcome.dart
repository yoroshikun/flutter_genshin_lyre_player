import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_genshin_lyre/components/widget_functions.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationPanelBody(
        index: 0,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Genshin Lyre Player',
                  style: Theme.of(context).typography?.header,
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(10),
                Text('Disclaimer',
                    style: Theme.of(context).typography?.subtitle),
                addVerticalSpace(10),
                Text(
                  'I take no responsibility for any actions potentially taken by MiHoYo against your account for using this program,\n although this program is harmless and made for entertainment purposes MiHoYo dissaproves of their use publically.\n That being said there have been no cases so far of anyone being banend for using such a program to play a lyre.',
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(10),
                Text(
                  'If you accept all responsibility for using this program continue with the button below',
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(10),
                Button(
                  onPressed: () {
                    Navigator.pushNamed(context, 'main');
                  },
                  text: Text('Lets get started!'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
