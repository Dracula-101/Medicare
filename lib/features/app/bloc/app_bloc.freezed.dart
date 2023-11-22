// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() disableFirstUse,
    required TResult Function() darkModeChanged,
    required TResult Function(User? user) userChanged,
    required TResult Function(List<LocalMedicine> medicines) addMedicines,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? disableFirstUse,
    TResult? Function()? darkModeChanged,
    TResult? Function(User? user)? userChanged,
    TResult? Function(List<LocalMedicine> medicines)? addMedicines,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? disableFirstUse,
    TResult Function()? darkModeChanged,
    TResult Function(User? user)? userChanged,
    TResult Function(List<LocalMedicine> medicines)? addMedicines,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_DisableFirstUse value) disableFirstUse,
    required TResult Function(_DarkModeChanged value) darkModeChanged,
    required TResult Function(_UserChanged value) userChanged,
    required TResult Function(_AddMedicine value) addMedicines,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_DisableFirstUse value)? disableFirstUse,
    TResult? Function(_DarkModeChanged value)? darkModeChanged,
    TResult? Function(_UserChanged value)? userChanged,
    TResult? Function(_AddMedicine value)? addMedicines,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_DisableFirstUse value)? disableFirstUse,
    TResult Function(_DarkModeChanged value)? darkModeChanged,
    TResult Function(_UserChanged value)? userChanged,
    TResult Function(_AddMedicine value)? addMedicines,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppEventCopyWith<$Res> {
  factory $AppEventCopyWith(AppEvent value, $Res Function(AppEvent) then) =
      _$AppEventCopyWithImpl<$Res, AppEvent>;
}

/// @nodoc
class _$AppEventCopyWithImpl<$Res, $Val extends AppEvent>
    implements $AppEventCopyWith<$Res> {
  _$AppEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl();

  @override
  String toString() {
    return 'AppEvent.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() disableFirstUse,
    required TResult Function() darkModeChanged,
    required TResult Function(User? user) userChanged,
    required TResult Function(List<LocalMedicine> medicines) addMedicines,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? disableFirstUse,
    TResult? Function()? darkModeChanged,
    TResult? Function(User? user)? userChanged,
    TResult? Function(List<LocalMedicine> medicines)? addMedicines,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? disableFirstUse,
    TResult Function()? darkModeChanged,
    TResult Function(User? user)? userChanged,
    TResult Function(List<LocalMedicine> medicines)? addMedicines,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_DisableFirstUse value) disableFirstUse,
    required TResult Function(_DarkModeChanged value) darkModeChanged,
    required TResult Function(_UserChanged value) userChanged,
    required TResult Function(_AddMedicine value) addMedicines,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_DisableFirstUse value)? disableFirstUse,
    TResult? Function(_DarkModeChanged value)? darkModeChanged,
    TResult? Function(_UserChanged value)? userChanged,
    TResult? Function(_AddMedicine value)? addMedicines,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_DisableFirstUse value)? disableFirstUse,
    TResult Function(_DarkModeChanged value)? darkModeChanged,
    TResult Function(_UserChanged value)? userChanged,
    TResult Function(_AddMedicine value)? addMedicines,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements AppEvent {
  const factory _Loaded() = _$LoadedImpl;
}

/// @nodoc
abstract class _$$DisableFirstUseImplCopyWith<$Res> {
  factory _$$DisableFirstUseImplCopyWith(_$DisableFirstUseImpl value,
          $Res Function(_$DisableFirstUseImpl) then) =
      __$$DisableFirstUseImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisableFirstUseImplCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$DisableFirstUseImpl>
    implements _$$DisableFirstUseImplCopyWith<$Res> {
  __$$DisableFirstUseImplCopyWithImpl(
      _$DisableFirstUseImpl _value, $Res Function(_$DisableFirstUseImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DisableFirstUseImpl implements _DisableFirstUse {
  const _$DisableFirstUseImpl();

  @override
  String toString() {
    return 'AppEvent.disableFirstUse()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisableFirstUseImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() disableFirstUse,
    required TResult Function() darkModeChanged,
    required TResult Function(User? user) userChanged,
    required TResult Function(List<LocalMedicine> medicines) addMedicines,
  }) {
    return disableFirstUse();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? disableFirstUse,
    TResult? Function()? darkModeChanged,
    TResult? Function(User? user)? userChanged,
    TResult? Function(List<LocalMedicine> medicines)? addMedicines,
  }) {
    return disableFirstUse?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? disableFirstUse,
    TResult Function()? darkModeChanged,
    TResult Function(User? user)? userChanged,
    TResult Function(List<LocalMedicine> medicines)? addMedicines,
    required TResult orElse(),
  }) {
    if (disableFirstUse != null) {
      return disableFirstUse();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_DisableFirstUse value) disableFirstUse,
    required TResult Function(_DarkModeChanged value) darkModeChanged,
    required TResult Function(_UserChanged value) userChanged,
    required TResult Function(_AddMedicine value) addMedicines,
  }) {
    return disableFirstUse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_DisableFirstUse value)? disableFirstUse,
    TResult? Function(_DarkModeChanged value)? darkModeChanged,
    TResult? Function(_UserChanged value)? userChanged,
    TResult? Function(_AddMedicine value)? addMedicines,
  }) {
    return disableFirstUse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_DisableFirstUse value)? disableFirstUse,
    TResult Function(_DarkModeChanged value)? darkModeChanged,
    TResult Function(_UserChanged value)? userChanged,
    TResult Function(_AddMedicine value)? addMedicines,
    required TResult orElse(),
  }) {
    if (disableFirstUse != null) {
      return disableFirstUse(this);
    }
    return orElse();
  }
}

abstract class _DisableFirstUse implements AppEvent {
  const factory _DisableFirstUse() = _$DisableFirstUseImpl;
}

/// @nodoc
abstract class _$$DarkModeChangedImplCopyWith<$Res> {
  factory _$$DarkModeChangedImplCopyWith(_$DarkModeChangedImpl value,
          $Res Function(_$DarkModeChangedImpl) then) =
      __$$DarkModeChangedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DarkModeChangedImplCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$DarkModeChangedImpl>
    implements _$$DarkModeChangedImplCopyWith<$Res> {
  __$$DarkModeChangedImplCopyWithImpl(
      _$DarkModeChangedImpl _value, $Res Function(_$DarkModeChangedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DarkModeChangedImpl implements _DarkModeChanged {
  const _$DarkModeChangedImpl();

  @override
  String toString() {
    return 'AppEvent.darkModeChanged()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DarkModeChangedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() disableFirstUse,
    required TResult Function() darkModeChanged,
    required TResult Function(User? user) userChanged,
    required TResult Function(List<LocalMedicine> medicines) addMedicines,
  }) {
    return darkModeChanged();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? disableFirstUse,
    TResult? Function()? darkModeChanged,
    TResult? Function(User? user)? userChanged,
    TResult? Function(List<LocalMedicine> medicines)? addMedicines,
  }) {
    return darkModeChanged?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? disableFirstUse,
    TResult Function()? darkModeChanged,
    TResult Function(User? user)? userChanged,
    TResult Function(List<LocalMedicine> medicines)? addMedicines,
    required TResult orElse(),
  }) {
    if (darkModeChanged != null) {
      return darkModeChanged();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_DisableFirstUse value) disableFirstUse,
    required TResult Function(_DarkModeChanged value) darkModeChanged,
    required TResult Function(_UserChanged value) userChanged,
    required TResult Function(_AddMedicine value) addMedicines,
  }) {
    return darkModeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_DisableFirstUse value)? disableFirstUse,
    TResult? Function(_DarkModeChanged value)? darkModeChanged,
    TResult? Function(_UserChanged value)? userChanged,
    TResult? Function(_AddMedicine value)? addMedicines,
  }) {
    return darkModeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_DisableFirstUse value)? disableFirstUse,
    TResult Function(_DarkModeChanged value)? darkModeChanged,
    TResult Function(_UserChanged value)? userChanged,
    TResult Function(_AddMedicine value)? addMedicines,
    required TResult orElse(),
  }) {
    if (darkModeChanged != null) {
      return darkModeChanged(this);
    }
    return orElse();
  }
}

abstract class _DarkModeChanged implements AppEvent {
  const factory _DarkModeChanged() = _$DarkModeChangedImpl;
}

/// @nodoc
abstract class _$$UserChangedImplCopyWith<$Res> {
  factory _$$UserChangedImplCopyWith(
          _$UserChangedImpl value, $Res Function(_$UserChangedImpl) then) =
      __$$UserChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$UserChangedImplCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$UserChangedImpl>
    implements _$$UserChangedImplCopyWith<$Res> {
  __$$UserChangedImplCopyWithImpl(
      _$UserChangedImpl _value, $Res Function(_$UserChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$UserChangedImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$UserChangedImpl implements _UserChanged {
  const _$UserChangedImpl({required this.user});

  @override
  final User? user;

  @override
  String toString() {
    return 'AppEvent.userChanged(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChangedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChangedImplCopyWith<_$UserChangedImpl> get copyWith =>
      __$$UserChangedImplCopyWithImpl<_$UserChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() disableFirstUse,
    required TResult Function() darkModeChanged,
    required TResult Function(User? user) userChanged,
    required TResult Function(List<LocalMedicine> medicines) addMedicines,
  }) {
    return userChanged(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? disableFirstUse,
    TResult? Function()? darkModeChanged,
    TResult? Function(User? user)? userChanged,
    TResult? Function(List<LocalMedicine> medicines)? addMedicines,
  }) {
    return userChanged?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? disableFirstUse,
    TResult Function()? darkModeChanged,
    TResult Function(User? user)? userChanged,
    TResult Function(List<LocalMedicine> medicines)? addMedicines,
    required TResult orElse(),
  }) {
    if (userChanged != null) {
      return userChanged(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_DisableFirstUse value) disableFirstUse,
    required TResult Function(_DarkModeChanged value) darkModeChanged,
    required TResult Function(_UserChanged value) userChanged,
    required TResult Function(_AddMedicine value) addMedicines,
  }) {
    return userChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_DisableFirstUse value)? disableFirstUse,
    TResult? Function(_DarkModeChanged value)? darkModeChanged,
    TResult? Function(_UserChanged value)? userChanged,
    TResult? Function(_AddMedicine value)? addMedicines,
  }) {
    return userChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_DisableFirstUse value)? disableFirstUse,
    TResult Function(_DarkModeChanged value)? darkModeChanged,
    TResult Function(_UserChanged value)? userChanged,
    TResult Function(_AddMedicine value)? addMedicines,
    required TResult orElse(),
  }) {
    if (userChanged != null) {
      return userChanged(this);
    }
    return orElse();
  }
}

abstract class _UserChanged implements AppEvent {
  const factory _UserChanged({required final User? user}) = _$UserChangedImpl;

  User? get user;
  @JsonKey(ignore: true)
  _$$UserChangedImplCopyWith<_$UserChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddMedicineImplCopyWith<$Res> {
  factory _$$AddMedicineImplCopyWith(
          _$AddMedicineImpl value, $Res Function(_$AddMedicineImpl) then) =
      __$$AddMedicineImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<LocalMedicine> medicines});
}

/// @nodoc
class __$$AddMedicineImplCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$AddMedicineImpl>
    implements _$$AddMedicineImplCopyWith<$Res> {
  __$$AddMedicineImplCopyWithImpl(
      _$AddMedicineImpl _value, $Res Function(_$AddMedicineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medicines = null,
  }) {
    return _then(_$AddMedicineImpl(
      medicines: null == medicines
          ? _value._medicines
          : medicines // ignore: cast_nullable_to_non_nullable
              as List<LocalMedicine>,
    ));
  }
}

/// @nodoc

class _$AddMedicineImpl implements _AddMedicine {
  const _$AddMedicineImpl({required final List<LocalMedicine> medicines})
      : _medicines = medicines;

  final List<LocalMedicine> _medicines;
  @override
  List<LocalMedicine> get medicines {
    if (_medicines is EqualUnmodifiableListView) return _medicines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medicines);
  }

  @override
  String toString() {
    return 'AppEvent.addMedicines(medicines: $medicines)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddMedicineImpl &&
            const DeepCollectionEquality()
                .equals(other._medicines, _medicines));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_medicines));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddMedicineImplCopyWith<_$AddMedicineImpl> get copyWith =>
      __$$AddMedicineImplCopyWithImpl<_$AddMedicineImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() disableFirstUse,
    required TResult Function() darkModeChanged,
    required TResult Function(User? user) userChanged,
    required TResult Function(List<LocalMedicine> medicines) addMedicines,
  }) {
    return addMedicines(medicines);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? disableFirstUse,
    TResult? Function()? darkModeChanged,
    TResult? Function(User? user)? userChanged,
    TResult? Function(List<LocalMedicine> medicines)? addMedicines,
  }) {
    return addMedicines?.call(medicines);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? disableFirstUse,
    TResult Function()? darkModeChanged,
    TResult Function(User? user)? userChanged,
    TResult Function(List<LocalMedicine> medicines)? addMedicines,
    required TResult orElse(),
  }) {
    if (addMedicines != null) {
      return addMedicines(medicines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_DisableFirstUse value) disableFirstUse,
    required TResult Function(_DarkModeChanged value) darkModeChanged,
    required TResult Function(_UserChanged value) userChanged,
    required TResult Function(_AddMedicine value) addMedicines,
  }) {
    return addMedicines(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_DisableFirstUse value)? disableFirstUse,
    TResult? Function(_DarkModeChanged value)? darkModeChanged,
    TResult? Function(_UserChanged value)? userChanged,
    TResult? Function(_AddMedicine value)? addMedicines,
  }) {
    return addMedicines?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_DisableFirstUse value)? disableFirstUse,
    TResult Function(_DarkModeChanged value)? darkModeChanged,
    TResult Function(_UserChanged value)? userChanged,
    TResult Function(_AddMedicine value)? addMedicines,
    required TResult orElse(),
  }) {
    if (addMedicines != null) {
      return addMedicines(this);
    }
    return orElse();
  }
}

abstract class _AddMedicine implements AppEvent {
  const factory _AddMedicine({required final List<LocalMedicine> medicines}) =
      _$AddMedicineImpl;

  List<LocalMedicine> get medicines;
  @JsonKey(ignore: true)
  _$$AddMedicineImplCopyWith<_$AddMedicineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppState {
  UIStatus get status => throw _privateConstructorUsedError;
  bool get isDarkMode => throw _privateConstructorUsedError;
  bool get isFirstUse => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  List<LocalMedicine> get medicines => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {UIStatus status,
      bool isDarkMode,
      bool isFirstUse,
      User? user,
      List<LocalMedicine> medicines});

  $UIStatusCopyWith<$Res> get status;
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? isDarkMode = null,
    Object? isFirstUse = null,
    Object? user = freezed,
    Object? medicines = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UIStatus,
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstUse: null == isFirstUse
          ? _value.isFirstUse
          : isFirstUse // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      medicines: null == medicines
          ? _value.medicines
          : medicines // ignore: cast_nullable_to_non_nullable
              as List<LocalMedicine>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UIStatusCopyWith<$Res> get status {
    return $UIStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UIStatus status,
      bool isDarkMode,
      bool isFirstUse,
      User? user,
      List<LocalMedicine> medicines});

  @override
  $UIStatusCopyWith<$Res> get status;
  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? isDarkMode = null,
    Object? isFirstUse = null,
    Object? user = freezed,
    Object? medicines = null,
  }) {
    return _then(_$AppStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UIStatus,
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstUse: null == isFirstUse
          ? _value.isFirstUse
          : isFirstUse // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      medicines: null == medicines
          ? _value._medicines
          : medicines // ignore: cast_nullable_to_non_nullable
              as List<LocalMedicine>,
    ));
  }
}

/// @nodoc

class _$AppStateImpl implements _AppState {
  const _$AppStateImpl(
      {this.status = const UIInitial(),
      this.isDarkMode = false,
      this.isFirstUse = true,
      this.user = null,
      final List<LocalMedicine> medicines = const []})
      : _medicines = medicines;

  @override
  @JsonKey()
  final UIStatus status;
  @override
  @JsonKey()
  final bool isDarkMode;
  @override
  @JsonKey()
  final bool isFirstUse;
  @override
  @JsonKey()
  final User? user;
  final List<LocalMedicine> _medicines;
  @override
  @JsonKey()
  List<LocalMedicine> get medicines {
    if (_medicines is EqualUnmodifiableListView) return _medicines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medicines);
  }

  @override
  String toString() {
    return 'AppState(status: $status, isDarkMode: $isDarkMode, isFirstUse: $isFirstUse, user: $user, medicines: $medicines)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.isFirstUse, isFirstUse) ||
                other.isFirstUse == isFirstUse) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality()
                .equals(other._medicines, _medicines));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, isDarkMode, isFirstUse,
      user, const DeepCollectionEquality().hash(_medicines));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {final UIStatus status,
      final bool isDarkMode,
      final bool isFirstUse,
      final User? user,
      final List<LocalMedicine> medicines}) = _$AppStateImpl;

  @override
  UIStatus get status;
  @override
  bool get isDarkMode;
  @override
  bool get isFirstUse;
  @override
  User? get user;
  @override
  List<LocalMedicine> get medicines;
  @override
  @JsonKey(ignore: true)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
