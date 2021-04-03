import 'package:fluent_ui/fluent_ui.dart';

Widget midiLoader(BuildContext context, Function() openMidi) => Center(
      child: Button(
        onPressed: () {
          openMidi();
        }, // Open dialog for midi selection
        text: Text(
          'Click to load a midi',
          style: Theme.of(context).typography?.subtitle,
        ),
      ),
    );
