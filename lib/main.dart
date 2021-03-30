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
              primarySwatch: Colors.purple,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepPurple,
              canvasColor: Colors.grey[850],
              backgroundColor: Colors.grey[850],
              textTheme: TextTheme(headline5: TextStyle(color: Colors.white)),
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

  void _openMidi() {
    final pickerFile = OpenFilePicker()
      ..filterSpecification = {'Midi file (*.mid)': '*.mid', 'All Files': '*.*'}
      ..defaultFilterIndex = 0
      ..defaultExtension = 'mid'
      ..title = 'Select a song';

    final result = pickerFile.getFile();

    if (result != null) {
      final file = File('/Users/Yoroshi/Downloads/m64wings.mid');
      final reader = MidiReader(file);
      setState(() {
        _reader = reader;
      });
    } else {
      setState(() {
        fileSelectError = true;
      });
    }
  }

  Widget welcomeChild(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print('hi');
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

  Widget loadedChild(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Speed',
                ),
              ),
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Length',
                ),
              ),
            )
          ]),
          ElevatedButton(
              onPressed: () => null,
              child: const Text('Play', style: TextStyle(fontSize: 18)))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
          child:
              _reader == null ? welcomeChild(context) : loadedChild(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.toggleMode,
        tooltip: 'Open Midi',
        child: widget.theme == ThemeMode.light
            ? const Icon(Icons.bedtime)
            : const Icon(Icons.wb_sunny),
      ),
    );
  }
}
