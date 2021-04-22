import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';
import '../utils/midi_player.dart';
import '../utils/midi_reader.dart';

part 'workspace.freezed.dart';

const _uuid = Uuid();

@freezed
abstract class Workspace with _$Workspace {
  const factory Workspace({
    required MidiPlayer player,
    required MidiReader reader,
    required File file,
    required String id,
  }) = _Workspace;

  // Custom initialization with auto generated id
  factory Workspace.create(MidiPlayer player, MidiReader reader, File file) {
    return Workspace(
        player: player, reader: reader, file: file, id: _uuid.v4());
  }
}

class Workspaces extends StateNotifier<List<Workspace>> {
  // final List<Workspace> _workspaces;
  // This allows for initialization for workspaces from saved state
  Workspaces(List<Workspace> _workspaces) : super(_workspaces);

  void add(Workspace workspace) {
    state = [...state, workspace];
  }

  void remove(String id) {
    state = state.whereNot((workspace) => workspace.id == id).toList();
  }

  void updatePlayingPosition(String id, int position) {
    final int workspaceIndex =
        state.indexWhere((workspace) => workspace.id == id);

    state[workspaceIndex].player.position = position;
  }

  void resetPlayer(String id) {
    final int workspaceIndex =
        state.indexWhere((workspace) => workspace.id == id);

    state[workspaceIndex].player.reset();

    state = state;
  }

  void pausePlayer(String id) {
    final int workspaceIndex =
        state.indexWhere((workspace) => workspace.id == id);

    state[workspaceIndex].player.pause();

    state = state;
  }

  void startPlayer(String id) {
    final int workspaceIndex =
        state.indexWhere((workspace) => workspace.id == id);

    state[workspaceIndex].player.play();

    state = state;
  }

  void setDelay(String id, int delay) {
    final int workspaceIndex =
        state.indexWhere((workspace) => workspace.id == id);

    state[workspaceIndex].player.delay = delay;
  }

  void setTickAccuracy(String id, double tickAccuracy) {
    final int workspaceIndex =
        state.indexWhere((workspace) => workspace.id == id);

    state[workspaceIndex].reader.tickAccuracy = tickAccuracy;
  }

  void calculateTracks(String id) {
    final int workspaceIndex =
        state.indexWhere((workspace) => workspace.id == id);

    state[workspaceIndex].reader.calculateTracks();

    state = state;
  }
}

final workspacesNotifierProvider =
    StateNotifierProvider<Workspaces, List<Workspace>>((ref) => Workspaces([]));
