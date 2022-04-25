// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'signup_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) {
  return _SignupRequest.fromJson(json);
}

/// @nodoc
mixin _$SignupRequest {
  String get email => throw _privateConstructorUsedError;
  String get nickName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get contactNo => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignupRequestCopyWith<SignupRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupRequestCopyWith<$Res> {
  factory $SignupRequestCopyWith(
          SignupRequest value, $Res Function(SignupRequest) then) =
      _$SignupRequestCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String nickName,
      String password,
      String contactNo,
      bool isAdmin});
}

/// @nodoc
class _$SignupRequestCopyWithImpl<$Res>
    implements $SignupRequestCopyWith<$Res> {
  _$SignupRequestCopyWithImpl(this._value, this._then);

  final SignupRequest _value;
  // ignore: unused_field
  final $Res Function(SignupRequest) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? nickName = freezed,
    Object? password = freezed,
    Object? contactNo = freezed,
    Object? isAdmin = freezed,
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
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      contactNo: contactNo == freezed
          ? _value.contactNo
          : contactNo // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: isAdmin == freezed
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$SignupRequestCopyWith<$Res>
    implements $SignupRequestCopyWith<$Res> {
  factory _$SignupRequestCopyWith(
          _SignupRequest value, $Res Function(_SignupRequest) then) =
      __$SignupRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String nickName,
      String password,
      String contactNo,
      bool isAdmin});
}

/// @nodoc
class __$SignupRequestCopyWithImpl<$Res>
    extends _$SignupRequestCopyWithImpl<$Res>
    implements _$SignupRequestCopyWith<$Res> {
  __$SignupRequestCopyWithImpl(
      _SignupRequest _value, $Res Function(_SignupRequest) _then)
      : super(_value, (v) => _then(v as _SignupRequest));

  @override
  _SignupRequest get _value => super._value as _SignupRequest;

  @override
  $Res call({
    Object? email = freezed,
    Object? nickName = freezed,
    Object? password = freezed,
    Object? contactNo = freezed,
    Object? isAdmin = freezed,
  }) {
    return _then(_SignupRequest(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nickName: nickName == freezed
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      contactNo: contactNo == freezed
          ? _value.contactNo
          : contactNo // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: isAdmin == freezed
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SignupRequest implements _SignupRequest {
  const _$_SignupRequest(
      {required this.email,
      required this.nickName,
      required this.password,
      required this.contactNo,
      required this.isAdmin});

  factory _$_SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$$_SignupRequestFromJson(json);

  @override
  final String email;
  @override
  final String nickName;
  @override
  final String password;
  @override
  final String contactNo;
  @override
  final bool isAdmin;

  @override
  String toString() {
    return 'SignupRequest(email: $email, nickName: $nickName, password: $password, contactNo: $contactNo, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignupRequest &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.nickName, nickName) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.contactNo, contactNo) &&
            const DeepCollectionEquality().equals(other.isAdmin, isAdmin));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(nickName),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(contactNo),
      const DeepCollectionEquality().hash(isAdmin));

  @JsonKey(ignore: true)
  @override
  _$SignupRequestCopyWith<_SignupRequest> get copyWith =>
      __$SignupRequestCopyWithImpl<_SignupRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SignupRequestToJson(this);
  }
}

abstract class _SignupRequest implements SignupRequest {
  const factory _SignupRequest(
      {required final String email,
      required final String nickName,
      required final String password,
      required final String contactNo,
      required final bool isAdmin}) = _$_SignupRequest;

  factory _SignupRequest.fromJson(Map<String, dynamic> json) =
      _$_SignupRequest.fromJson;

  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get nickName => throw _privateConstructorUsedError;
  @override
  String get password => throw _privateConstructorUsedError;
  @override
  String get contactNo => throw _privateConstructorUsedError;
  @override
  bool get isAdmin => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SignupRequestCopyWith<_SignupRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
