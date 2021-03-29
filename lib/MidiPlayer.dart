import 'dart:io';
import 'package:dart_midi/dart_midi.dart';

class MidiPlayer {
  final letter = {
    'a': 65,
    'b': 66,
    'c': 67,
    'd': 68,
    'e': 69,
    'f': 70,
    'g': 71,
    'h': 72,
    'i': 73,
    'j': 74,
    'k': 75,
    'l': 76,
    'm': 77,
    'n': 78,
    'o': 79,
    'p': 80,
    'q': 81,
    'r': 82,
    's': 83,
    't': 84,
    'u': 85,
    'v': 86,
    'w': 87,
    'x': 88,
    'y': 89,
    'z': 90
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
  int delay = 4000;

  // Unused Code ?
  // Map<String, int> _dinput() {
  //   final Map<String, int> a = {};
  //   int count = 36;

  //   while (count <= 84) {
  //     a[count.toString()] = input();
  //     count++;
  //   }

  //   return a;
  // }

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
    if (mapping.keys.contains(note)) {
      // win32api.keybd_event(letter[mapping[note]], 0, 0, 0)
    }
  }

  void _unpress(String note) {
    // 48 to 83
    if (mapping.keys.contains(note)) {
      // win32api.keybd_event(letter[mapping[note]], 0, win32con.KEYEVENTF_KEYUP, 0)
    }
  }

  void _make_map() {
    String s = "zxcvbnmasdfghjqwertyu";

    mapping.keys.toList().asMap().forEach((i, k) {
      mapping[k] = s[i];
    });
  }

  void play() {
    // print("Song will start playing in " + str(stime) + " seconds, please be prepared to switch over to Genshin Impact.")
    sleep(Duration(milliseconds: delay));

    // Player
    //   for i in range(mmax):
    // if i != 0:
    // 	for note in start[str(i - 1)]:
    // 		unpress(str(note))
    // for note in start[str(i)]:
    // 	press(str(note))
    // time.sleep(0.025)
    playing = true;
  }

  void pause() {
    playing = false;
  }

  void reset() {
    playing = false;
    seek = 0;
  }
}
