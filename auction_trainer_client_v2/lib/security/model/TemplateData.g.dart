// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TemplateData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateData _$TemplateDataFromJson(Map<String, dynamic> json) => TemplateData(
      templateName: json['templateName'] as String,
      lotNames:
          (json['lotNames'] as List<dynamic>).map((e) => e as String).toList(),
      lotDescriptions: (json['lotDescriptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => TemplateRound.fromJson(e as Map<String, dynamic>))
          .toList(),
      betParams: json['betParams'] == null
          ? null
          : BetParams.fromJson(json['betParams'] as Map<String, dynamic>),
      lotDuration: json['lotDuration'] as int?,
      lotPauseDuration: json['lotPauseDuration'] as int?,
      roundPauseDuration: json['roundPauseDuration'] as int?,
      manualMode: json['manualMode'] as bool,
    );

Map<String, dynamic> _$TemplateDataToJson(TemplateData instance) =>
    <String, dynamic>{
      'templateName': instance.templateName,
      'lotNames': instance.lotNames,
      'lotDescriptions': instance.lotDescriptions,
      'rounds': instance.rounds,
      'betParams': instance.betParams,
      'lotDuration': instance.lotDuration,
      'lotPauseDuration': instance.lotPauseDuration,
      'roundPauseDuration': instance.roundPauseDuration,
      'manualMode': instance.manualMode,
    };
