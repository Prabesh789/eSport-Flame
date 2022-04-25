// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'signup_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) {
  return _SignupResponse.fromJson(json);
}

/// @nodoc
mixin _$SignupResponse {
  String get email => throw _privateConstructorUsedError;
  String get nickName => throw _privateConstructorUsedError;
  String get contactNo => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignupResponseCopyWith<SignupResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupResponseCopyWith<$Res> {
  factory $SignupResponseCopyWith(
          SignupResponse value, $Res Function(SignupResponse) then) =
      _$SignupResponseCopyWithImpl<$Res>;
  $Res call({String email, String nickName, String contactNo, String message});
}

/// @nodoc
class _$SignupResponseCopyWithImpl<$Res>
    implements $SignupResponseCopyWith<$Res> {
  _$SignupResponseCopyWithImpl(this._value, this._then);

  final SignupResponse _value;
  // ignore: unused_field
  final $Res Function(SignupResponse) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? nickName = freezed,
    Object? contactNo = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nickName: nickName == freezed
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      contactNo: contactNo == freezed
          ? _value.contactNo
          : contactNo // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$SignupResponseCopyWith<$Res>
    implements $SignupResponseCopyWith<$Res> {
  factory _$SignupResponseCopyWith(
          _SignupResponse value, $Res Function(_SignupResponse) then) =
      __$SignupResponseCopyWithImpl<$Res>;
  @override
  $Res call({String email, String nickName, String contactNo, String message});
}

/// @nodoc
class __$SignupResponseCopyWithImpl<$Res>
    extends _$SignupResponseCopyWithImpl<$Res>
    implements _$SignupResponseCopyWith<$Res> {
  __$SignupResponseCopyWithImpl(
      _SignupResponse _value, $Res Function(_SignupResponse) _then)
      : super(_value, (v) => _then(v as _SignupResponse));

  @override
  _SignupResponse get _value => super._value as _SignupResponse;

  @override
  $Res call({
    Object? email = freezed,
    Object? nickName = freezed,
    Object? contactNo = freezed,
    Object? message = freezed,
  }) {
    return _then(_SignupResponse(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nickName: nickName == freezed
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      contactNo: contactNo == freezed
          ? _value.contactNo
          : contactNo // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SignupResponse implements _SignupResponse {
  const _$_SignupResponse(
      {required this.email,
      required this.nickName,
      required this.contactNo,
      required this.message});

  factory _$_SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SignupResponseFromJson(json);

  @override
  final String email;
  @override
  final String nickName;
  @override
  final String contactNo;
  @override
  final String message;

  @override
  String toString() {
    return 'SignupResponse(email: $email, nickName: $nickName, contactNo: $contactNo, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignupResponse &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.nickName, nickName) &&
            const DeepCollectionEquality().equals(other.contactNo, contactNo) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(nickName),
      const DeepCollectionEquality().hash(contactNo),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$SignupResponseCopyWith<_SignupResponse> get copyWith =>
      __$SignupResponseCopyWithImpl<_SignupResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SignupResponseToJson(this);
  }
}

abstract class _SignupResponse implements SignupResponse {
  const factory _SignupResponse(
      {required final String email,
      required final String nickName,
      required final String contactNo,
      required final String message}) = _$_SignupResponse;

  factory _SignupResponse.fromJson(Map<String, dynamic> json) =
      _$_SignupResponse.fromJson;

  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get nickName => throw _privateConstructorUsedError;
  @override
  String get contactNo => throw _privateConstructorUsedError;
  @override
  String get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SignupResponseCopyWith<_SignupResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
