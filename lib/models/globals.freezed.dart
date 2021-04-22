// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'globals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GlobalsTearOff {
  const _$GlobalsTearOff();

  _Globals call(
      {bool playing = false, bool testMode = false, int menuIndex = 0}) {
    return _Globals(
      playing: playing,
      testMode: testMode,
      menuIndex: menuIndex,
    );
  }
}

/// @nodoc
const $Globals = _$GlobalsTearOff();

/// @nodoc
mixin _$Globals {
  bool get playing => throw _privateConstructorUsedError;
  bool get testMode => throw _privateConstructorUsedError;
  int get menuIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GlobalsCopyWith<Globals> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlobalsCopyWith<$Res> {
  factory $GlobalsCopyWith(Globals value, $Res Function(Globals) then) =
      _$GlobalsCopyWithImpl<$Res>;
  $Res call({bool playing, bool testMode, int menuIndex});
}

/// @nodoc
class _$GlobalsCopyWithImpl<$Res> implements $GlobalsCopyWith<$Res> {
  _$GlobalsCopyWithImpl(this._value, this._then);

  final Globals _value;
  // ignore: unused_field
  final $Res Function(Globals) _then;

  @override
  $Res call({
    Object? playing = freezed,
    Object? testMode = freezed,
    Object? menuIndex = freezed,
  }) {
    return _then(_value.copyWith(
      playing: playing == freezed
          ? _value.playing
          : playing // ignore: cast_nullable_to_non_nullable
              as bool,
      testMode: testMode == freezed
          ? _value.testMode
          : testMode // ignore: cast_nullable_to_non_nullable
              as bool,
      menuIndex: menuIndex == freezed
          ? _value.menuIndex
          : menuIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$GlobalsCopyWith<$Res> implements $GlobalsCopyWith<$Res> {
  factory _$GlobalsCopyWith(_Globals value, $Res Function(_Globals) then) =
      __$GlobalsCopyWithImpl<$Res>;
  @override
  $Res call({bool playing, bool testMode, int menuIndex});
}

/// @nodoc
class __$GlobalsCopyWithImpl<$Res> extends _$GlobalsCopyWithImpl<$Res>
    implements _$GlobalsCopyWith<$Res> {
  __$GlobalsCopyWithImpl(_Globals _value, $Res Function(_Globals) _then)
      : super(_value, (v) => _then(v as _Globals));

  @override
  _Globals get _value => super._value as _Globals;

  @override
  $Res call({
    Object? playing = freezed,
    Object? testMode = freezed,
    Object? menuIndex = freezed,
  }) {
    return _then(_Globals(
      playing: playing == freezed
          ? _value.playing
          : playing // ignore: cast_nullable_to_non_nullable
              as bool,
      testMode: testMode == freezed
          ? _value.testMode
          : testMode // ignore: cast_nullable_to_non_nullable
              as bool,
      menuIndex: menuIndex == freezed
          ? _value.menuIndex
          : menuIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
class _$_Globals with DiagnosticableTreeMixin implements _Globals {
  const _$_Globals(
      {this.playing = false, this.testMode = false, this.menuIndex = 0});

  @JsonKey(defaultValue: false)
  @override
  final bool playing;
  @JsonKey(defaultValue: false)
  @override
  final bool testMode;
  @JsonKey(defaultValue: 0)
  @override
  final int menuIndex;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Globals(playing: $playing, testMode: $testMode, menuIndex: $menuIndex)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Globals'))
      ..add(DiagnosticsProperty('playing', playing))
      ..add(DiagnosticsProperty('testMode', testMode))
      ..add(DiagnosticsProperty('menuIndex', menuIndex));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Globals &&
            (identical(other.playing, playing) ||
                const DeepCollectionEquality()
                    .equals(other.playing, playing)) &&
            (identical(other.testMode, testMode) ||
                const DeepCollectionEquality()
                    .equals(other.testMode, testMode)) &&
            (identical(other.menuIndex, menuIndex) ||
                const DeepCollectionEquality()
                    .equals(other.menuIndex, menuIndex)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(playing) ^
      const DeepCollectionEquality().hash(testMode) ^
      const DeepCollectionEquality().hash(menuIndex);

  @JsonKey(ignore: true)
  @override
  _$GlobalsCopyWith<_Globals> get copyWith =>
      __$GlobalsCopyWithImpl<_Globals>(this, _$identity);
}

abstract class _Globals implements Globals {
  const factory _Globals({bool playing, bool testMode, int menuIndex}) =
      _$_Globals;

  @override
  bool get playing => throw _privateConstructorUsedError;
  @override
  bool get testMode => throw _privateConstructorUsedError;
  @override
  int get menuIndex => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GlobalsCopyWith<_Globals> get copyWith =>
      throw _privateConstructorUsedError;
}
