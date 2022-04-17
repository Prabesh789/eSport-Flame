// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SignupRequest _$$_SignupRequestFromJson(Map<String, dynamic> json) =>
    _$_SignupRequest(
      email: json['email'] as String,
      nickName: json['nickName'] as String,
      password: json['password'] as String,
      contactNo: json['contactNo'] as String,
      isAdmin: json['isAdmin'] as bool,
    );

Map<String, dynamic> _$$_SignupRequestToJson(_$_SignupRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nickName': instance.nickName,
      'password': instance.password,
      'contactNo': instance.contactNo,
      'isAdmin': instance.isAdmin,
    };
