// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BetParams.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BetParams _$BetParamsFromJson(Map<String, dynamic> json) => BetParams(
      startSum: json['startSum'] as int?,
      limitSum: json['limitSum'] as int?,
      minBetStep: json['minBetStep'] as int?,
    );

Map<String, dynamic> _$BetParamsToJson(BetParams instance) => <String, dynamic>{
      'startSum': instance.startSum,
      'limitSum': instance.limitSum,
      'minBetStep': instance.minBetStep,
    };
