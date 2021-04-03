import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter_genshin_lyre/screens/player/loader.dart';
import 'package:flutter_genshin_lyre/screens/player/settings.dart';
import 'package:flutter_genshin_lyre/screens/player/viewer.dart';

import '../utils/midi_player.dart';
import '../utils/midi_reader.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.title, this.theme, this.toggleMode})
      : super(key: key);

  final String? title;
  final ThemeMode? theme;
  final Function()? toggleMode;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool fileSelectError = false;
  List<Map<String, dynamic>> workspaces = <Map<String, dynamic>>[];
  // MidiReader? _reader;
  // MidiPlayer? _player;
  // File? file;
  // int _playerPosition = 0;
  bool _playing = false;
  bool _testMode = false;

  void _openMidi() {
    final pickerFile = OpenFilePicker()
      ..filterSpecification = {'Midi file (*.mid)': '*.mid', 'All Files': '*.*'}
      ..defaultFilterIndex = 0
      ..defaultExtension = 'mid'
      ..title = 'Select a song';

    final result = pickerFile.getFile();

    if (result != null) {
      final file = File(result.path);
      final reader = MidiReader(file);
      final player = MidiPlayer(workspaces.length, reader.midiLength,
          reader.playTracks, _updatePlayerPosition, _updatePlaying);
      final Map<String, dynamic> workspace = <String, dynamic>{};
      workspace['player'] = player;
      workspace['reader'] = reader;
      workspace['file'] = file;

      setState(() {
        workspaces.add(workspace);
        _currentIndex = workspaces.length;
      });
    } else {
      setState(() {
        fileSelectError = true;
      });
    }
  }

  void _clearWorkspace(int index) {
    workspaces.removeAt(index);

    // Update indexes
    workspaces.asMap().forEach((index, workspace) {
      workspace['player'].index = index;
    });

    setState(() {
      workspaces = workspaces;
    });
  }

  void _resetPlayer(int index) {
    workspaces[index]['player'].reset(); // Wish this could be typed
    setState(() => {workspaces = workspaces, _playing = false});
  }

  void _pausePlayer(int index) {
    workspaces[index]['player'].pause(); // Wish this could be typed
    setState(() => _playing = false);
  }

  void _startPlayer(int index) {
    workspaces[index]['player']
        .play(testMode: _testMode); // Wish this could be typed
    setState(() => _playing = true);
  }

  void _updatePlayerPosition(int index, int position) {
    workspaces[index]['player'].position = position;

    setState(() => workspaces[index]['player'] = workspaces[index]['player']);
  }

  void _setDelay(int index, int delay) {
    workspaces[index]['player'].delay = delay;

    setState(() => workspaces[index]['player'] = workspaces[index]['player']);
  }

  void _setTickAccuracy(int index, double tickAccuracy) {
    workspaces[index]['reader'].tickAccuracy = tickAccuracy;

    setState(() => workspaces[index]['reader'] = workspaces[index]['reader']);
  }

  void _setIndex(int index) {
    setState(() => _currentIndex = index);
  }

  void _setTestMode(bool testMode) {
    setState(() => _testMode = testMode);
  }

  void _updatePlaying(bool playing) {
    setState(() => _playing = playing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      left: NavigationPanel(
        currentIndex: _currentIndex,
        menu: NavigationPanelMenuItem(icon: Icon(Icons.text_align_justify)),
        items: [
          NavigationPanelItem(
            icon: Icon(Icons.folder_add),
            label: Text('Load new midi'),
            onTapped: () => setState(() => _currentIndex = 0),
          ),
          NavigationPanelTileSeparator(),
          ...workspaces
              .asMap()
              .map(
                (index, workspace) => MapEntry<int, NavigationPanelItem>(
                  index,
                  NavigationPanelItem(
                      icon: Icon(Icons.music),
                      label: Text(workspace['file']
                          .path
                          .split("\\")
                          .removeLast()
                          .replaceFirst('.mid', '') as String),
                      onTapped: () {
                        if (_currentIndex - 1 >= 0) {
                          _pausePlayer(_currentIndex - 1);
                        }
                        setState(() => _currentIndex = index + 1);
                      }),
                ),
              )
              .values
              .toList(),
        ],
        bottom: NavigationPanelItem(
          icon: Icon(Icons.settings),
          label: Text('Settings'),
          onTapped: () => setState(() => _currentIndex = workspaces.length + 1),
        ),
      ),
      body: NavigationPanelBody(
        index: _currentIndex,
        transitionBuilder: (child, animation) {
          // Refer to page transitions to see more page transitions
          return EntrancePageTransition(
            animation: animation,
            child: child,
          );
        },
        children: [
          midiLoader(context, _openMidi),
          ...workspaces.map(
            (workspace) => midiViewer(context,
                reader: workspace['reader'] as MidiReader,
                player: workspace['player'] as MidiPlayer,
                setTickAccuracy: _setTickAccuracy,
                setIndex: _setIndex,
                setDelay: _setDelay,
                setPosition: _updatePlayerPosition,
                clearWorkspace: _clearWorkspace,
                testMode: _testMode,
                setTestMode: _setTestMode,
                startPlayer: _startPlayer,
                resetPlayer: _resetPlayer,
                pausePlayer: _pausePlayer,
                playing: _playing),
          ),
          settings(context, widget.toggleMode)
        ],
      ),
      footer: Acrylic(
        padding: EdgeInsets.all(12), // Defaults to EdgeInsets.zero
        color: Colors.grey,
        opacity: 0.4,
        width: double.infinity,
        child: Center(
          child: Text('Made with <3 by Yoroshi',
              style: Theme.of(context).typography?.caption),
        ),
      ),
    );
  }
}
