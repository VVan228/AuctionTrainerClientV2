// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Round.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Round _$RoundFromJson(Map<String, dynamic> json) => Round(
      intervalId: json['intervalId'] as int,
      lots: (json['lots'] as List<dynamic>)
          .map((e) => Lot.fromJson(e as Map<String, dynamic>))
          .toList(),
      ascending: json['ascending'] as bool,
      status: Round._statusFromJson(json['status'] as String),
    );

Map<String, dynamic> _$RoundToJson(Round instance) => <String, dynamic>{
      'ascending': instance.ascending,
      'status': Round._statusToJson(instance.status),
      'lots': instance.lots,
      'intervalId': instance.intervalId,
    };
