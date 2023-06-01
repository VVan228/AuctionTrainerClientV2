// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Lot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lot _$LotFromJson(Map<String, dynamic> json) => Lot(
      status: Lot._statusFromJson(json['status'] as String),
      duration: json['duration'] as int,
      autoend: json['autoend'] as bool,
      intervalId: json['intervalId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      betParams: BetParams.fromJson(json['betParams'] as Map<String, dynamic>),
      winner: json['winner'] == null
          ? null
          : ParticipantBet.fromJson(json['winner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LotToJson(Lot instance) => <String, dynamic>{
      'status': Lot._statusToJson(instance.status),
      'duration': instance.duration,
      'autoend': instance.autoend,
      'intervalId': instance.intervalId,
      'name': instance.name,
      'description': instance.description,
      'betParams': instance.betParams,
      'winner': instance.winner,
    };
