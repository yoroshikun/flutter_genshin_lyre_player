import 'dart:io';
import 'dart:math';
import 'dart_midi/dart_midi.dart';

class MidiReader {
  late MidiFile midiObject;
  late File midiFile;
  int midiLength = 0;
  double tickAccuracy = 0.0;
  final List<List<int>> playTracks = [];

  List<int> _find(List<dynamic> arr, int time) {
    final List<int> result = <int>[];

    for (final i in arr) {
      if (i["time"] == time) {
        result.add(i["note"] as int);
      }
    }

    return result;
  }

  MidiReader(File file) {
    midiFile = file;

    // Construct a midi parser
    final parser = MidiParser();

    // Parse midi directly from file.
    midiObject = parser.parseMidiFromFile(file);

    // Automatically set playback_speed
    try {
      bool flag = false;
      int tempo = 0;

      for (final track in midiObject.tracks) {
        for (final midi_event in track) {
          if (midi_event is SetTempoEvent) {
            flag = true;
            tempo = midi_event.microsecondsPerBeat;
            break;
          }
        }

        final double bpm = 60000000 / tempo;
        tickAccuracy = bpm / 20;

        if (flag) {
          break;
        }
      }
    } catch (err) {
      tickAccuracy = 7;
    }

    // Start Converting Tracks

    final List<Map<String, int>> tracks = [];
    final List<Map<String, int>> endTracks = [];

    midiObject.tracks.toList().asMap().forEach((i, track) {
      int lastTime = 0;
      int lastOn = 0;

      for (final message in track) {
        final Map<String, int> info = <String, int>{};

        info['pertime'] = message.deltaTime; // Is per time used
        info['time'] = message.deltaTime + lastTime;
        lastTime = info['time']!;

        if (message is NoteOnEvent || message is NoteOffEvent) {
          info['time'] = (info['time']! / tickAccuracy).round();
          lastOn = info['time']!;

          if (message is NoteOnEvent) {
            info['note'] = message.noteNumber;
            tracks.add(info);
          }
          if (message is NoteOffEvent) {
            info['note'] = message.noteNumber;
            endTracks.add(info);
          }
        }
      }
    });

    endTracks.forEach((track) {
      midiLength = max(midiLength, track['time']! + 1);
    });

    List<int>.generate(midiLength, (i) => i).forEach((index) {
      final result = _find(tracks, index);
      playTracks.add(result);
    });
  }
}
