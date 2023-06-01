

import 'package:auction_trainer_client_v2/security/model/BetParams.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TemplateRound.g.dart';

@JsonSerializable()
class TemplateRound {
  BetParams? betParams;
  int? lotDuration;
  int? lotPauseDuration;
  int? roundPauseDuration;
  bool ascending;


  TemplateRound(
      {this.betParams,
        this.lotDuration,
        this.lotPauseDuration,
        this.roundPauseDuration,
        required this.ascending});

  factory TemplateRound.fromJson(Map<String, dynamic> json) => _$TemplateRoundFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateRoundToJson(this);
}