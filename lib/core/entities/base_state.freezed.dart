// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'base_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BaseState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(T? data) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseInitial<T> value) initial,
    required TResult Function(BaseLoading<T> value) loading,
    required TResult Function(BaseError<T> value) error,
    required TResult Function(BaseSuccess<T> value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseStateCopyWith<T, $Res> {
  factory $BaseStateCopyWith(
          BaseState<T> value, $Res Function(BaseState<T>) then) =
      _$BaseStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$BaseStateCopyWithImpl<T, $Res> implements $BaseStateCopyWith<T, $Res> {
  _$BaseStateCopyWithImpl(this._value, this._then);

  final BaseState<T> _value;
  // ignore: unused_field
  final $Res Function(BaseState<T>) _then;
}

/// @nodoc
abstract class $BaseInitialCopyWith<T, $Res> {
  factory $BaseInitialCopyWith(
          BaseInitial<T> value, $Res Function(BaseInitial<T>) then) =
      _$BaseInitialCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$BaseInitialCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res>
    implements $BaseInitialCopyWith<T, $Res> {
  _$BaseInitialCopyWithImpl(
      BaseInitial<T> _value, $Res Function(BaseInitial<T>) _then)
      : super(_value, (v) => _then(v as BaseInitial<T>));

  @override
  BaseInitial<T> get _value => super._value as BaseInitial<T>;
}

/// @nodoc

class _$BaseInitial<T> implements BaseInitial<T> {
  const _$BaseInitial();

  @override
  String toString() {
    return 'BaseState<$T>.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BaseInitial<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(T? data) success,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseInitial<T> value) initial,
    required TResult Function(BaseLoading<T> value) loading,
    required TResult Function(BaseError<T> value) error,
    required TResult Function(BaseSuccess<T> value) success,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BaseInitial<T> implements BaseState<T> {
  const factory BaseInitial() = _$BaseInitial<T>;
}

/// @nodoc
abstract class $BaseLoadingCopyWith<T, $Res> {
  factory $BaseLoadingCopyWith(
          BaseLoading<T> value, $Res Function(BaseLoading<T>) then) =
      _$BaseLoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$BaseLoadingCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res>
    implements $BaseLoadingCopyWith<T, $Res> {
  _$BaseLoadingCopyWithImpl(
      BaseLoading<T> _value, $Res Function(BaseLoading<T>) _then)
      : super(_value, (v) => _then(v as BaseLoading<T>));

  @override
  BaseLoading<T> get _value => super._value as BaseLoading<T>;
}

/// @nodoc

class _$BaseLoading<T> implements BaseLoading<T> {
  const _$BaseLoading();

  @override
  String toString() {
    return 'BaseState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BaseLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(T? data) success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseInitial<T> value) initial,
    required TResult Function(BaseLoading<T> value) loading,
    required TResult Function(BaseError<T> value) error,
    required TResult Function(BaseSuccess<T> value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BaseLoading<T> implements BaseState<T> {
  const factory BaseLoading() = _$BaseLoading<T>;
}

/// @nodoc
abstract class $BaseErrorCopyWith<T, $Res> {
  factory $BaseErrorCopyWith(
          BaseError<T> value, $Res Function(BaseError<T>) then) =
      _$BaseErrorCopyWithImpl<T, $Res>;
  $Res call({Failure failure});
}

/// @nodoc
class _$BaseErrorCopyWithImpl<T, $Res> extends _$BaseStateCopyWithImpl<T, $Res>
    implements $BaseErrorCopyWith<T, $Res> {
  _$BaseErrorCopyWithImpl(
      BaseError<T> _value, $Res Function(BaseError<T>) _then)
      : super(_value, (v) => _then(v as BaseError<T>));

  @override
  BaseError<T> get _value => super._value as BaseError<T>;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(BaseError<T>(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$BaseError<T> implements BaseError<T> {
  const _$BaseError(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'BaseState<$T>.error(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BaseError<T> &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  $BaseErrorCopyWith<T, BaseError<T>> get copyWith =>
      _$BaseErrorCopyWithImpl<T, BaseError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(T? data) success,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseInitial<T> value) initial,
    required TResult Function(BaseLoading<T> value) loading,
    required TResult Function(BaseError<T> value) error,
    required TResult Function(BaseSuccess<T> value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BaseError<T> implements BaseState<T> {
  const factory BaseError(final Failure failure) = _$BaseError<T>;

  Failure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaseErrorCopyWith<T, BaseError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseSuccessCopyWith<T, $Res> {
  factory $BaseSuccessCopyWith(
          BaseSuccess<T> value, $Res Function(BaseSuccess<T>) then) =
      _$BaseSuccessCopyWithImpl<T, $Res>;
  $Res call({T? data});
}

/// @nodoc
class _$BaseSuccessCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res>
    implements $BaseSuccessCopyWith<T, $Res> {
  _$BaseSuccessCopyWithImpl(
      BaseSuccess<T> _value, $Res Function(BaseSuccess<T>) _then)
      : super(_value, (v) => _then(v as BaseSuccess<T>));

  @override
  BaseSuccess<T> get _value => super._value as BaseSuccess<T>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(BaseSuccess<T>(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$BaseSuccess<T> implements BaseSuccess<T> {
  const _$BaseSuccess({this.data});

  @override
  final T? data;

  @override
  String toString() {
    return 'BaseState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BaseSuccess<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  $BaseSuccessCopyWith<T, BaseSuccess<T>> get copyWith =>
      _$BaseSuccessCopyWithImpl<T, BaseSuccess<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(T? data) success,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(T? data)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseInitial<T> value) initial,
    required TResult Function(BaseLoading<T> value) loading,
    required TResult Function(BaseError<T> value) error,
    required TResult Function(BaseSuccess<T> value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseInitial<T> value)? initial,
    TResult Function(BaseLoading<T> value)? loading,
    TResult Function(BaseError<T> value)? error,
    TResult Function(BaseSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class BaseSuccess<T> implements BaseState<T> {
  const factory BaseSuccess({final T? data}) = _$BaseSuccess<T>;

  T? get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaseSuccessCopyWith<T, BaseSuccess<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
