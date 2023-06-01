// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TemplateRound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateRound _$TemplateRoundFromJson(Map<String, dynamic> json) =>
    TemplateRound(
      betParams: json['betParams'] == null
          ? null
          : BetParams.fromJson(json['betParams'] as Map<String, dynamic>),
      lotDuration: json['lotDuration'] as int?,
      lotPauseDuration: json['lotPauseDuration'] as int?,
      roundPauseDuration: json['roundPauseDuration'] as int?,
      ascending: json['ascending'] as bool,
    );

Map<String, dynamic> _$TemplateRoundToJson(TemplateRound instance) =>
    <String, dynamic>{
      'betParams': instance.betParams,
      'lotDuration': instance.lotDuration,
      'lotPauseDuration': instance.lotPauseDuration,
      'roundPauseDuration': instance.roundPauseDuration,
      'ascending': instance.ascending,
    };
