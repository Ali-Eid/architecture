// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponseModelImpl<T> _$$ResponseModelImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$ResponseModelImpl<T>(
      message: json['message'] as String? ?? '',
      code: json['code'] as String? ?? '',
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$$ResponseModelImplToJson<T>(
  _$ResponseModelImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': toJsonT(instance.data),
    };
