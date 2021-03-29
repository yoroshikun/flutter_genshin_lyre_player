import 'dart:io';
import 'dart:ffi';

import 'dart_midi/dart_midi.dart';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class MidiPlayer {
  final letter = {
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
  final mapping = {
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

  bool playing = false;
  int tick_accuracy = 0;
  int bpm = 0;
  int seek = 0;
  int delay = 10000;
  late Pointer<INPUT> kbd;

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
    // print("Song will start playing in " + str(stime) + " seconds, please be prepared to switch over to Genshin Impact.")
    sleep(Duration(milliseconds: delay));

    // Allocate memory for keyboard control
    kbd = calloc<INPUT>();
    kbd.ref.type = INPUT_KEYBOARD;

    // Player
    //   for i in range(mmax):
    // if i != 0:
    // 	for note in start[str(i - 1)]:
    // 		unpress(str(note))
    // for note in start[str(i)]:
    // 	press(str(note))
    // time.sleep(0.025)
  }

  void pause() {
    // Free memory for keyboard control
    free(kbd);
    playing = false;
  }

  void reset() {
    playing = false;
    seek = 0;
  }
}
