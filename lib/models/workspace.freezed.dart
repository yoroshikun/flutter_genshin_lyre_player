// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'workspace.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WorkspaceTearOff {
  const _$WorkspaceTearOff();

  _Workspace call(
      {required MidiPlayer player,
      required MidiReader reader,
      required File file,
      required String id}) {
    return _Workspace(
      player: player,
      reader: reader,
      file: file,
      id: id,
    );
  }
}

/// @nodoc
const $Workspace = _$WorkspaceTearOff();

/// @nodoc
mixin _$Workspace {
  MidiPlayer get player => throw _privateConstructorUsedError;
  MidiReader get reader => throw _privateConstructorUsedError;
  File get file => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorkspaceCopyWith<Workspace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkspaceCopyWith<$Res> {
  factory $WorkspaceCopyWith(Workspace value, $Res Function(Workspace) then) =
      _$WorkspaceCopyWithImpl<$Res>;
  $Res call({MidiPlayer player, MidiReader reader, File file, String id});
}

/// @nodoc
class _$WorkspaceCopyWithImpl<$Res> implements $WorkspaceCopyWith<$Res> {
  _$WorkspaceCopyWithImpl(this._value, this._then);

  final Workspace _value;
  // ignore: unused_field
  final $Res Function(Workspace) _then;

  @override
  $Res call({
    Object? player = freezed,
    Object? reader = freezed,
    Object? file = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      player: player == freezed
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as MidiPlayer,
      reader: reader == freezed
          ? _value.reader
          : reader // ignore: cast_nullable_to_non_nullable
              as MidiReader,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$WorkspaceCopyWith<$Res> implements $WorkspaceCopyWith<$Res> {
  factory _$WorkspaceCopyWith(
          _Workspace value, $Res Function(_Workspace) then) =
      __$WorkspaceCopyWithImpl<$Res>;
  @override
  $Res call({MidiPlayer player, MidiReader reader, File file, String id});
}

/// @nodoc
class __$WorkspaceCopyWithImpl<$Res> extends _$WorkspaceCopyWithImpl<$Res>
    implements _$WorkspaceCopyWith<$Res> {
  __$WorkspaceCopyWithImpl(_Workspace _value, $Res Function(_Workspace) _then)
      : super(_value, (v) => _then(v as _Workspace));

  @override
  _Workspace get _value => super._value as _Workspace;

  @override
  $Res call({
    Object? player = freezed,
    Object? reader = freezed,
    Object? file = freezed,
    Object? id = freezed,
  }) {
    return _then(_Workspace(
      player: player == freezed
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as MidiPlayer,
      reader: reader == freezed
          ? _value.reader
          : reader // ignore: cast_nullable_to_non_nullable
              as MidiReader,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$_Workspace with DiagnosticableTreeMixin implements _Workspace {
  const _$_Workspace(
      {required this.player,
      required this.reader,
      required this.file,
      required this.id});

  @override
  final MidiPlayer player;
  @override
  final MidiReader reader;
  @override
  final File file;
  @override
  final String id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Workspace(player: $player, reader: $reader, file: $file, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Workspace'))
      ..add(DiagnosticsProperty('player', player))
      ..add(DiagnosticsProperty('reader', reader))
      ..add(DiagnosticsProperty('file', file))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Workspace &&
            (identical(other.player, player) ||
                const DeepCollectionEquality().equals(other.player, player)) &&
            (identical(other.reader, reader) ||
                const DeepCollectionEquality().equals(other.reader, reader)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(player) ^
      const DeepCollectionEquality().hash(reader) ^
      const DeepCollectionEquality().hash(file) ^
      const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$WorkspaceCopyWith<_Workspace> get copyWith =>
      __$WorkspaceCopyWithImpl<_Workspace>(this, _$identity);
}

abstract class _Workspace implements Workspace {
  const factory _Workspace(
      {required MidiPlayer player,
      required MidiReader reader,
      required File file,
      required String id}) = _$_Workspace;

  @override
  MidiPlayer get player => throw _privateConstructorUsedError;
  @override
  MidiReader get reader => throw _privateConstructorUsedError;
  @override
  File get file => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WorkspaceCopyWith<_Workspace> get copyWith =>
      throw _privateConstructorUsedError;
}
