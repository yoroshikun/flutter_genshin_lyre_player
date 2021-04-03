import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_genshin_lyre/utils/midi_reader.dart';
import 'package:flutter_genshin_lyre/utils/midi_player.dart';
import 'package:flutter_genshin_lyre/utils/widget_functions.dart';

final delays = [
  '1000',
  '2000',
  '3000',
  '4000',
  '5000',
  '6000',
  '7000',
  '8000',
  '9000',
  '10000'
];

Widget midiViewer(BuildContext context,
        {MidiReader? reader,
        MidiPlayer? player,
        void Function(int, double)? setTickAccuracy,
        void Function(int, int)? setDelay,
        void Function(int, int)? setPosition,
        void Function(int)? setIndex,
        void Function(int)? clearWorkspace,
        void Function(bool)? setTestMode,
        void Function(int)? resetPlayer,
        void Function(int)? startPlayer,
        void Function(int)? pausePlayer,
        bool testMode = false,
        bool playing = false}) =>
    Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${reader?.midiFile.path.split("\\").removeLast().replaceFirst('.mid', '')}', // Name can be set by reader
            style: Theme.of(context).typography?.subheader,
          ),
          addVerticalSpace(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Acrylic(
                  opacity: 0.4,
                  color: Colors.blue,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Information',
                        style: Theme.of(context).typography?.subtitle,
                      ),
                      addVerticalSpace(10),
                      Text('Length: ${reader?.midiLength} notes',
                          style: Theme.of(context)
                              .typography
                              ?.body), // Change to seconds
                      SizedBox(width: 10),
                      Text(
                          'Tick Accuracy: ${reader?.tickAccuracy.toStringAsFixed(2)}',
                          style: Theme.of(context).typography?.body),
                      Text('Current Position: ${player?.position}',
                          style: Theme.of(context).typography?.body),
                      addVerticalSpace(10),
                      Text(
                        'Test Mode',
                        style: Theme.of(context).typography?.base,
                      ),
                      ToggleSwitch(
                        checked: testMode,
                        onChanged: (v) => setTestMode!(v),
                      )
                    ],
                  ),
                ),
              ),
              addHorisontalSpace(10),
              Expanded(
                child: Acrylic(
                  opacity: 0.4,
                  color: Colors.yellow,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Options',
                        style: Theme.of(context).typography?.subtitle,
                      ),
                      addVerticalSpace(10),
                      Text(
                        'Tick Accuracy',
                        style: Theme.of(context).typography?.base,
                      ),
                      addVerticalSpace(10),
                      Slider(
                        min: 1,
                        max: 50,
                        value: reader!.tickAccuracy,
                        onChanged: (v) => setTickAccuracy!(player!.index, v),
                        onChangeEnd: (v) => reader.calculateTracks(),
                        // Label is the text displayed above the slider when the user is interacting with it.
                        label: '${reader.tickAccuracy.toStringAsFixed(2)}',
                      ),
                      addVerticalSpace(10),
                      Text(
                        'Delay',
                        style: Theme.of(context).typography?.base,
                      ),
                      addVerticalSpace(5),
                      SizedBox(
                        width: 140,
                        child: ComboBox<String>(
                          placeholder: 'Delay',
                          isExpanded: true,
                          items: delays
                              .map((delay) => ComboboxMenuItem<String>(
                                    value: delay,
                                    child: Text('$delay ms'),
                                  ))
                              .toList(),
                          value: player!.delay.toString(),
                          onChanged: (value) {
                            if (value != null) {
                              setDelay!(player.index, int.parse(value));
                            }
                          },
                        ),
                      ),
                      addVerticalSpace(5),
                      Button(
                        text: Text('Remove Midi'),
                        onPressed: () => showDialog<void>(
                          context: context,
                          builder: (context) {
                            return ContentDialog(
                              title: Text(
                                  'Remove ${reader.midiFile.path.split("\\").removeLast().replaceFirst('.mid', '')}'),
                              content: Text(
                                  'Are you sure you want to remove this midi file?'),
                              actions: [
                                Button(
                                    text: Text('Remove'),
                                    onPressed: () {
                                      setIndex!(0);
                                      clearWorkspace!(player.index);
                                      Navigator.pop(context);
                                    })
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          addVerticalSpace(30),
          Center(
            child: SizedBox(
              width: 400,
              child: Column(
                children: [
                  Text(
                    'Position',
                    style: Theme.of(context).typography?.base,
                  ),
                  addVerticalSpace(10),
                  Slider(
                    max: reader.midiLength.toDouble(),
                    value: player.position.toDouble(),
                    onChanged: (v) => setPosition!(player.index, v.floor()),
                    // Label is the text displayed above the slider when the user is interacting with it.
                    label: '${player.position}',
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => resetPlayer!(player.index),
                child: Icon(Icons.previous, size: 28),
              ),
              addHorisontalSpace(10),
              GestureDetector(
                onTap: () => playing
                    ? pausePlayer!(player.index)
                    : startPlayer!(player.index),
                child: playing
                    ? Icon(Icons.pause, size: 48)
                    : Icon(Icons.play_circle, size: 48),
              ),
              addHorisontalSpace(10),
              GestureDetector(
                onTap: () => setPosition!(player.index, player.position + 100),
                child: Icon(Icons.next, size: 28),
              )
            ],
          ),
        ],
      ),
    );
