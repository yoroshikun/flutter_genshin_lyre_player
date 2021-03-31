import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

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

void _press(String note, Pointer<INPUT> kbd) {
  // Make these return an error so we can tell the user
  // 48 to 83
  final key = letter[mapping[note]];

  if (key != null) {
    kbd.ki.dwFlags = 0;
    kbd.ki.wVk = key;
    final result = SendInput(1, kbd, sizeOf<INPUT>());
    if (result != TRUE)
      print('Error: ${GetLastError()}'); // todo: Custom error handler
  }
}

void _unpress(String note, Pointer<INPUT> kbd) {
  // Make these return an error so we can tell the user
  // 48 to 83
  final key = letter[mapping[note]];

  if (key != null) {
    kbd.ki.dwFlags = KEYEVENTF_KEYUP;
    final result = SendInput(1, kbd, sizeOf<INPUT>());
    if (result != TRUE)
      print('Error: ${GetLastError()}'); // todo: Custom error handler
  }
}

// Player Isolate
void playerIsolate(SendPort isolateToMainStream) {
  final ReceivePort mainToIsolateStream = ReceivePort();
  isolateToMainStream.send(mainToIsolateStream.sendPort);

  mainToIsolateStream.listen((dynamic data) {
    final int resumePosition = data['position'] as int;
    final int midiLength = data['midiLength'] as int;
    final List<List<int>> playTracks = data['playTracks'] as List<List<int>>;

    // Allocate pointer for keyboard control
    final Pointer<INPUT> kbd = calloc<INPUT>();
    kbd.ref.type = INPUT_KEYBOARD;

    for (final index
        in List<int>.generate(midiLength - resumePosition, (i) => i)) {
      List<int> previousTrack = [];

      if (index != 0) {
        previousTrack = playTracks[(index + resumePosition) - 1];
      }

      final List<int> currentTrack = playTracks[(index + resumePosition)];

      for (final note in previousTrack) {
        _unpress(note.toString(), kbd);
      }

      for (final note in currentTrack) {
        _press(note.toString(), kbd);
      }

      Map<String, int> sendData = {};
      sendData['position'] = index + resumePosition;
      isolateToMainStream.send(sendData);
      Sleep(25);
    }

    // Free pointer for keyboard control once we are done with playing
    free(kbd);
  });
}

class MidiPlayer {
  bool playing = false;
  int position = 0;
  int delay = 10000;
  int midiLength = 0;
  double tickAccuracy = 0.0; // Is tickAccuracy needed here?
  List<List<int>> playTracks = [];
  void Function(int) _updatePosition;
  late SendPort mainToIsolateStream;
  Isolate? playerInstance;

  MidiPlayer(this.midiLength, this.tickAccuracy, this.playTracks,
      this._updatePosition);

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

  // Unused Code ? Debug?
  void _make_map() {
    String s = "zxcvbnmasdfghjqwertyu";

    mapping.keys.toList().asMap().forEach((i, k) {
      mapping[k] = s[i];
    });
  }

  // Isolate the player so that it does not block the main thread!
  // Init 2 way communication with Isolate
  Future<SendPort> initPlayerIsolate() async {
    final Completer completer = Completer<SendPort>();
    final ReceivePort isolateToMainStream = ReceivePort();

    isolateToMainStream.listen((dynamic data) {
      if (data is SendPort) {
        final SendPort mainToIsolateStream = data;
        completer.complete(mainToIsolateStream);
      } else {
        position = data['position'] as int;
        _updatePosition(position);
        // Debug anything else that is passed back
        // print('[isolateToMainStream] $data');
      }
    });

    playerInstance =
        await Isolate.spawn(playerIsolate, isolateToMainStream.sendPort);
    return completer.future as Future<SendPort>;
  }

  Future<void> play(bool testMode) async {
    playing = true;

    if (testMode) {
      ShellExecute(
          0, TEXT('open'), TEXT('notepad.exe'), nullptr, nullptr, SW_SHOW);
      Sleep(1000);
    }

    Sleep(delay);

    final SendPort mainToIsolateStream = await initPlayerIsolate();
    Map<String, dynamic> sendData = <String, dynamic>{};
    sendData['position'] = position;
    sendData['midiLength'] = midiLength;
    sendData['playTracks'] =
        playTracks; // Possibly calculate the required playTracks here for optimized memory

    mainToIsolateStream.send(sendData);

    playing = false;
  }

  void pause() {
    playing = false;
    if (playerInstance != null) {
      playerInstance?.kill(priority: Isolate.immediate);
    }
  }

  void reset() {
    playing = false;
    position = 0;

    if (playerInstance != null) {
      playerInstance?.kill(priority: Isolate.immediate);
    }
  }
}
