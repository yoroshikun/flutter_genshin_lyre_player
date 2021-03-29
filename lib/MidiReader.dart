import 'dart:io';
import 'dart_midi/dart_midi.dart';

const type = ['note_on', 'note_off'];

class MidiReader {
  late MidiFile midiObject;
  late File midiFile;
  double tickAccuracy = 0.0;

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

    List<dynamic> tracks;
    List<dynamic> end_track;

    midiObject.tracks.toList().asMap().forEach((i, track) {
      int last_time = 0;
      int last_on = 0;
      for (final message in track) {
        Map<String, dynamic> info;
        // message
      }
    });
  }
}

// for i,track in enumerate(midi_object.tracks):
// 	print(f'track{i}')
// 	last_time = 0
// 	last_on = 0
// 	for msg in track:
// 		info = msg.dict()
// 		info['pertime'] = info['time']
// 		info['time'] += last_time
// 		last_time = info['time']
// 		if (info['type'] in type):
// 			del info['channel']
// 			del info['velocity']
// 			info['time'] = round(info['time'] / tick_accuracy)
// 			if info['type'] == 'note_on':
// 				del info['type']
// 				del info['pertime']
// 				last_on = info['time']
// 				tracks.append(info)
// 			else:
// 				del info['type']
// 				del info['pertime']
// 				last_on = info['time']
// 				end_track.append(info)
// mmax = 0
// for i in end_track:
// 	mmax = max(mmax, i['time'] + 1)
// start = {}
// print("Start converting the score...")
// for i in range(mmax):
// 	start[str(i)] = find(tracks, i)
