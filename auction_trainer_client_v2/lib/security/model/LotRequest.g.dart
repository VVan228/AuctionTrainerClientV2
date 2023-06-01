// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LotRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotRequest _$LotRequestFromJson(Map<String, dynamic> json) => LotRequest(
      duration: json['duration'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      betParams: json['betParams'] == null
          ? null
          : BetParams.fromJson(json['betParams'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LotRequestToJson(LotRequest instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'name': instance.name,
      'description': instance.description,
      'betParams': instance.betParams,
    };
