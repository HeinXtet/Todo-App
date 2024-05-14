// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodoListResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoListResponseImpl _$$TodoListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TodoListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TodoListResponseImplToJson(
        _$TodoListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
