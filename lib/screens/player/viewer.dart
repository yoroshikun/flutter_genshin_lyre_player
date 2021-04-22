import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_genshin_lyre/models/globals.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_genshin_lyre/models/workspace.dart';
import 'package:flutter_genshin_lyre/components/widget_functions.dart';

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

Widget midiViewer(BuildContext context, Workspace workspace,
        {bool testMode = false, bool playing = false}) =>
    Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            workspace.reader.midiFile.path
                .split("\\")
                .removeLast()
                .replaceFirst('.mid', ''),
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
                      Text('Length: ${workspace.reader.midiLength} notes',
                          style: Theme.of(context)
                              .typography
                              ?.body), // Change to seconds
                      SizedBox(width: 10),
                      Text(
                          'Tick Accuracy: ${workspace.reader.tickAccuracy.toStringAsFixed(2)}',
                          style: Theme.of(context).typography?.body),
                      Text('Current Position: ${workspace.player.position}',
                          style: Theme.of(context).typography?.body),
                      addVerticalSpace(10),
                      Text(
                        'Test Mode',
                        style: Theme.of(context).typography?.base,
                      ),
                      ToggleSwitch(
                        checked: testMode,
                        onChanged: (v) => context
                            .read(globalsNotifierProvider.notifier)
                            .setTestMode(testMode: v),
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
                        value: workspace.reader.tickAccuracy,
                        onChanged: (v) => context
                            .read(workspacesNotifierProvider.notifier)
                            .setTickAccuracy(workspace.id, v),
                        onChangeEnd: (v) => context
                            .read(workspacesNotifierProvider.notifier)
                            .calculateTracks(workspace.id),
                        // Label is the text displayed above the slider when the user is interacting with it.
                        label: workspace.reader.tickAccuracy.toStringAsFixed(2),
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
                          value: workspace.player.delay.toString(),
                          onChanged: (value) {
                            if (value != null) {
                              context
                                  .read(workspacesNotifierProvider.notifier)
                                  .setDelay(workspace.id, int.parse(value));
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
                                  'Remove ${workspace.reader.midiFile.path.split("\\").removeLast().replaceFirst('.mid', '')}'),
                              content: Text(
                                  'Are you sure you want to remove this midi file?'),
                              actions: [
                                Button(
                                    text: Text('Remove'),
                                    onPressed: () {
                                      context
                                          .read(
                                              globalsNotifierProvider.notifier)
                                          .setMenuIndex(0);
                                      context
                                          .read(workspacesNotifierProvider
                                              .notifier)
                                          .remove(workspace.id);
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
                    max: workspace.reader.midiLength.toDouble(),
                    value: workspace.player.position.toDouble(),
                    onChanged: (v) => context
                        .read(workspacesNotifierProvider.notifier)
                        .updatePlayingPosition(workspace.id, v.floor()),
                    // Label is the text displayed above the slider when the user is interacting with it.
                    label: '${workspace.player.position}',
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
                onTap: () => context
                    .read(workspacesNotifierProvider.notifier)
                    .resetPlayer(workspace.id),
                child: Icon(Icons.previous, size: 28),
              ),
              addHorisontalSpace(10),
              GestureDetector(
                onTap: () {
                  final workspaceNotifier =
                      context.read(workspacesNotifierProvider.notifier);
                  playing
                      ? workspaceNotifier.pausePlayer(workspace.id)
                      : workspaceNotifier.startPlayer(workspace.id);
                },
                child: playing
                    ? Icon(Icons.pause, size: 48)
                    : Icon(Icons.play_circle, size: 48),
              ),
              addHorisontalSpace(10),
              GestureDetector(
                onTap: () => context
                    .read(workspacesNotifierProvider.notifier)
                    .updatePlayingPosition(
                        workspace.id, workspace.player.position + 100),
                child: Icon(Icons.next, size: 28),
              )
            ],
          ),
        ],
      ),
    );
