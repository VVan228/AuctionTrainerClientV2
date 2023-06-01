

import 'package:auction_trainer_client_v2/security/model/TemplateRound.dart';
import 'package:json_annotation/json_annotation.dart';

import 'BetParams.dart';

part 'TemplateData.g.dart';

@JsonSerializable()
class TemplateData {
  String templateName;
  List<String> lotNames;
  List<String> lotDescriptions;
  List<TemplateRound> rounds;
  BetParams? betParams;
  int? lotDuration;
  int? lotPauseDuration;
  int? roundPauseDuration;
  bool manualMode;

  TemplateData({
    required this.templateName,
    required this.lotNames,
    required this.lotDescriptions,
    required this.rounds,
    this.betParams,
    this.lotDuration,
    this.lotPauseDuration,
    this.roundPauseDuration,
    required this.manualMode});

  factory TemplateData.fromJson(Map<String, dynamic> json) => _$TemplateDataFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateDataToJson(this);
}