import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

const letter = {
  'a': 0x41,
  'b': 0x42,
  'c': 0x43,
  'd': 0x44,
  'e': 0x45,
  'f': 0x46,
  'g': 0x47,
  'h': 0x48,
  'i': 0x49,
  'j': 0x4A,
  'k': 0x4B,
  'l': 0x4C,
  'm': 0x4D,
  'n': 0x4E,
  'o': 0x4F,
  'p': 0x50,
  'q': 0x51,
  'r': 0x52,
  's': 0x53,
  't': 0x54,
  'u': 0x55,
  'v': 0x56,
  'w': 0x57,
  'x': 0x58,
  'y': 0x59,
  'z': 0x5A
};
const mapping = {
  '48': 'z',
  '50': 'x',
  '52': 'c',
  '53': 'v',
  '55': 'b',
  '57': 'n',
  '59': 'm',
  '60': 'a',
  '62': 's',
  '64': 'd',
  '65': 'f',
  '67': 'g',
  '69': 'h',
  '71': 'j',
  '72': 'q',
  '74': 'w',
  '76': 'e',
  '77': 'r',
  '79': 't',
  '81': 'y',
  '83': 'u'
};

class MidiPlayer {
  bool playing = false;
  int position = 0;
  int delay = 10000;
  int midiLength = 0;
  double tickAccuracy = 0.0;
  List<Map<String, int>> playTracks = [];
  late Pointer<INPUT> kbd;

  MidiPlayer(this.midiLength, this.tickAccuracy, this.playTracks);

  // Unused Code ? Debug?
  Map<String, int> _dinput() {
    final Map<String, int> a = {};
    int count = 36;

    while (count <= 84) {
      // a[count.toString()] = input();
      count++;
    }

    return a;
  }

  List<dynamic> _find(List<dynamic> arr, int time) {
    final List<dynamic> result = <dynamic>[];

    for (final i in arr) {
      if (i["time"] == time) {
        result.add(i["time"]);
      }
    }

    return result;
  }

  void _press(String note) {
    // 48 to 83
    final key = letter[mapping[note]];

    if (key != null) {
      kbd.ki.wVk = key;
      final result = SendInput(1, kbd, sizeOf<INPUT>());
      if (result != TRUE)
        print('Error: ${GetLastError()}'); // todo: Custom error handler
    }
  }

  void _unpress(String note) {
    // 48 to 83
    final key = letter[mapping[note]];

    if (key != null) {
      kbd.ki.dwFlags = KEYEVENTF_KEYUP;
      final result = SendInput(1, kbd, sizeOf<INPUT>());
      if (result != TRUE)
        print('Error: ${GetLastError()}'); // todo: Custom error handler
    }
  }

  void _make_map() {
    String s = "zxcvbnmasdfghjqwertyu";

    mapping.keys.toList().asMap().forEach((i, k) {
      mapping[k] = s[i];
    });
  }

  void play() {
    playing = true;
    sleep(Duration(milliseconds: delay));

    // Allocate pointer for keyboard control
    kbd = calloc<INPUT>();
    kbd.ref.type = INPUT_KEYBOARD;
    final int previousPosition = position;

    for (final index
        in List<int>.generate(midiLength - previousPosition, (i) => i + 1)) {
      if (playing) {
        final Map<String, int> previousTrack = playTracks[index - 1];
        final Map<String, int> currentTrack = playTracks[index];

        for (final note in previousTrack.values) {
          _unpress(note.toString());
        }

        for (final note in currentTrack.values) {
          _press(note.toString());
        }

        position = index + previousPosition;
        sleep(const Duration(milliseconds: 25));
      } else {
        // Free pointer for keyboard control once we are done with playing
        free(kbd);
        break;
      }
    }

    playing = false;
  }

  void pause() {
    playing = false;
  }

  void reset() {
    playing = false;
    position = 0;
  }
}
