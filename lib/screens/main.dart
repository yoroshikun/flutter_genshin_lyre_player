import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter_genshin_lyre/models/globals.dart';
import 'package:flutter_genshin_lyre/models/theme.dart';
import 'package:flutter_genshin_lyre/screens/player/loader.dart';
import 'package:flutter_genshin_lyre/screens/player/settings.dart';
import 'package:flutter_genshin_lyre/screens/player/viewer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/workspace.dart';
import '../utils/midi_player.dart';
import '../utils/midi_reader.dart';

class MainScreen extends HookWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = useProvider(themeProvider);
    final globals = useProvider(globalsNotifierProvider);
    final workspaces = useProvider(workspacesNotifierProvider);

    void _openMidi() {
      final pickerFile = OpenFilePicker()
        ..filterSpecification = {
          'Midi file (*.mid)': '*.mid',
          'All Files': '*.*'
        }
        ..defaultFilterIndex = 0
        ..defaultExtension = 'mid'
        ..title = 'Select a song';

      final result = pickerFile.getFile();

      if (result != null) {
        final workspaceNotifier =
            context.read(workspacesNotifierProvider.notifier);
        final globalsNotifier = context.read(globalsNotifierProvider.notifier);
        final _uuid = Uuid().v4();
        final file = File(result.path);
        final reader = MidiReader(file);
        final player = MidiPlayer(
            _uuid,
            reader.midiLength,
            reader.playTracks,
            workspaceNotifier.updatePlayingPosition,
            globalsNotifier.setPlaying);
        workspaceNotifier.add(
            Workspace(id: _uuid, player: player, reader: reader, file: file));
        globalsNotifier.setMenuIndex(workspaces.length);
      } else {
        // Show error toast
        // setState(() {
        //   fileSelectError = true;
        // });
      }
    }

    return Scaffold(
      left: NavigationPanel(
        currentIndex: globals.menuIndex,
        menu: NavigationPanelMenuItem(icon: Icon(Icons.text_align_justify)),
        items: [
          NavigationPanelItem(
            icon: Icon(Icons.folder_add),
            label: Text('Load new midi'),
            onTapped: () =>
                context.read(globalsNotifierProvider.notifier).setMenuIndex(0),
          ),
          NavigationPanelTileSeparator(),
          ...workspaces
              .asMap()
              .map(
                (index, workspace) => MapEntry<int, NavigationPanelItem>(
                  index,
                  NavigationPanelItem(
                      icon: Icon(Icons.music),
                      label: Text(workspace.file.path
                          .split("\\")
                          .removeLast()
                          .replaceFirst('.mid', '')),
                      onTapped: () {
                        if (globals.menuIndex - 1 >= 0) {
                          context
                              .read(workspacesNotifierProvider.notifier)
                              .pausePlayer(workspace.id);
                        }
                        context
                            .read(globalsNotifierProvider.notifier)
                            .setMenuIndex(index + 1);
                      }),
                ),
              )
              .values
              .toList(),
        ],
        bottom: NavigationPanelItem(
          icon: Icon(Icons.settings),
          label: Text('Settings'),
          onTapped: () => context
              .read(globalsNotifierProvider.notifier)
              .setMenuIndex(workspaces.length + 1),
        ),
      ),
      body: NavigationPanelBody(
        index: globals.menuIndex,
        transitionBuilder: (child, animation) {
          // Refer to page transitions to see more page transitions
          return EntrancePageTransition(
            animation: animation,
            child: child,
          );
        },
        children: [
          midiLoader(context, _openMidi),
          ...workspaces.map(
            (workspace) => midiViewer(context, workspace,
                testMode: globals.testMode, playing: globals.playing),
          ),
          settings(context, theme.toggleMode)
        ],
      ),
      footer: Acrylic(
        padding: EdgeInsets.all(12), // Defaults to EdgeInsets.zero
        color: Colors.grey,
        opacity: 0.4,
        width: double.infinity,
        child: Center(child: Text('Made with <3 by Yoroshi')),
      ),
    );
  }
}
