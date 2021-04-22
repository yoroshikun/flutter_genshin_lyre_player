import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';

part 'globals.freezed.dart';

@freezed
abstract class Globals with _$Globals {
  const factory Globals({
    @Default(false) bool playing,
    @Default(false) bool testMode,
    @Default(0) int menuIndex,
  }) = _Globals;
}

class GlobalsNotifier extends StateNotifier<Globals> {
  GlobalsNotifier(Globals globals) : super(globals);

  void setPlaying({bool playing = false}) {
    state = state.copyWith(playing: playing);
  }

  void setTestMode({bool testMode = false}) {
    state = state.copyWith(testMode: testMode);
  }

  void setMenuIndex(int index) {
    state = state.copyWith(menuIndex: index);
  }
}

final globalsNotifierProvider = StateNotifierProvider<GlobalsNotifier, Globals>(
    (ref) => GlobalsNotifier(Globals()));
