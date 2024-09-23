// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ikimono.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IkimonoImpl _$$IkimonoImplFromJson(Map<String, dynamic> json) =>
    _$IkimonoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      user: json['user'] as String,
      location: json['location'] as String,
      tag: json['tag'] as String,
      capturedDate: DateTime.parse(json['captured_date'] as String),
      ikimonoUrl: json['ikimono_url'] as String,
    );

Map<String, dynamic> _$$IkimonoImplToJson(_$IkimonoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'user': instance.user,
      'location': instance.location,
      'tag': instance.tag,
      'captured_date': instance.capturedDate.toIso8601String(),
      'ikimono_url': instance.ikimonoUrl,
    };
