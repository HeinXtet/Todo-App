// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      name: json['Name'] as String,
      description: json['Description'] as String,
      id: (json['ID'] as num).toInt(),
      createdAt: json['CreatedAt'] as String,
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Description': instance.description,
      'ID': instance.id,
      'CreatedAt': instance.createdAt,
    };
