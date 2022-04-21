// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BaseResponse _$$_BaseResponseFromJson(Map<String, dynamic> json) =>
    _$_BaseResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$$_BaseResponseToJson(_$_BaseResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
