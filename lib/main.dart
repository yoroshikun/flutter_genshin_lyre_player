import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filepicker_windows/filepicker_windows.dart';

import 'MidiReader.dart';
import 'MidiPlayer.dart';

void main() {
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
          return MaterialApp(
            title: 'Genshin Auto Lyre',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepPurple,
              canvasColor: Colors.grey[850],
              backgroundColor: Colors.grey[850],
              textTheme: TextTheme(
                headline1: TextStyle(color: Colors.white),
                headline2: TextStyle(color: Colors.white),
                headline3: TextStyle(color: Colors.white),
                headline4: TextStyle(color: Colors.white),
                headline5: TextStyle(color: Colors.white),
                headline6: TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepPurpleAccent),
            ),
            themeMode: model.mode,
            home: MyHomePage(
                title: 'Genshin Auto Lyre',
                theme: model._mode,
                toggleMode: model.toggleMode),
          );
        },
      ),
    );
  }
}

class ThemeModel with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeModel({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title, this.theme, this.toggleMode})
      : super(key: key);

  final String? title;
  final ThemeMode? theme;
  final Function()? toggleMode;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool fileSelectError = false;
  MidiReader? _reader;
  MidiPlayer? _player;
  File? file;
  bool _playing = false;
  int _playerPosition = 0;
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

      setState(() {
        _reader = reader;
      });
      final player = MidiPlayer(reader.midiLength, reader.tickAccuracy,
          reader.playTracks, _updatePosition, _updatePlaying);

      setState(() {
        _player = player;
      });
    } else {
      setState(() {
        fileSelectError = true;
      });
    }
  }

  void _clear() {
    _player?.reset();
    setState(() {
      _playing = false;
      _playerPosition = 0;
      _reader = null;
      _player = null;
    });
  }

  void _resetPlayer() {
    _player?.reset();
    setState(() => {_playerPosition = 0, _playing = false});
  }

  void _pausePlayer() {
    _player?.pause();
    setState(() => _playing = false);
  }

  void _startPlayer(int position) {
    _player?.play(_testMode);
    setState(() => _playing = true);
  }

  void _updatePosition(int position) {
    setState(() => _playerPosition = position);
  }

  void _updatePlaying(bool playing) {
    setState(() => _playing = playing);
  }

  Widget welcomeChild(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _openMidi();
            }, // Open dialog for midi selection
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: SizedBox(
                width: 320,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Click to load a midi',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Icon(
                      Icons.folder,
                      color: Colors.grey,
                      size: 36.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget loadedChild(BuildContext context) => SizedBox(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loaded Midi: ${_reader?.midiFile.path.split("\\").removeLast().replaceFirst('.mid', '')}', // Name can be set by reader
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            Text(
              'midi info', // Name can be set by reader
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Length: ${_reader?.midiLength} notes',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1), // Change to seconds
                SizedBox(width: 10),
                Text('Position: note ${_player?.position}',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Speed: ${_reader?.tickAccuracy}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1), // Change to seconds
                SizedBox(width: 10),
                Text('Delay: ${_player?.delay} milliseconds',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            Text('Test Mode: $_testMode',
                style: Theme.of(context).textTheme.bodyText1),
            Text('Playing: $_playing',
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: [
                    ElevatedButton.icon(
                      label: const Text('Play', style: TextStyle(fontSize: 18)),
                      icon: const Icon(Icons.play_arrow),
                      style: _playing
                          ? ElevatedButton.styleFrom(primary: Colors.grey[400])
                          : ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () async =>
                          _playing ? null : _startPlayer(_playerPosition),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      label:
                          const Text('Pause', style: TextStyle(fontSize: 18)),
                      icon: const Icon(Icons.pause),
                      onPressed: () async => _playing ? _pausePlayer() : null,
                      style: _playing
                          ? ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[400])
                          : ElevatedButton.styleFrom(primary: Colors.grey[400]),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton.icon(
                      label:
                          const Text('Reset', style: TextStyle(fontSize: 18)),
                      icon: const Icon(Icons.settings_backup_restore_outlined),
                      onPressed: () async => _playing ? _resetPlayer() : null,
                      style: _playing
                          ? ElevatedButton.styleFrom(
                              primary: Colors.orange[400])
                          : ElevatedButton.styleFrom(primary: Colors.grey[400]),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      label:
                          const Text('Clear', style: TextStyle(fontSize: 18)),
                      icon: const Icon(Icons.restore_from_trash_rounded),
                      onPressed: () async => _clear(),
                      style: ElevatedButton.styleFrom(primary: Colors.red[400]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              label: const Text('Toggle Test Mode',
                  style: TextStyle(fontSize: 18)),
              icon: const Icon(Icons.text_snippet),
              onPressed: () => setState(() => _testMode = !_testMode),
              style: ElevatedButton.styleFrom(primary: Colors.red[400]),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title!),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _reader == null ? welcomeChild(context) : loadedChild(context),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Text(
                  'Made with <3 by Yoroshi and the open source community',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.toggleMode,
        tooltip: 'Toggle Dark Mode',
        child: widget.theme == ThemeMode.light
            ? const Icon(Icons.bedtime)
            : const Icon(Icons.wb_sunny),
      ),
    );
  }
}
