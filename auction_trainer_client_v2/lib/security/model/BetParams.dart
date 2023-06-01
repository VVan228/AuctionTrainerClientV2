

import 'package:json_annotation/json_annotation.dart';

part 'BetParams.g.dart';

@JsonSerializable()
class BetParams {
  int? startSum;
  int? limitSum;
  int? minBetStep;

  BetParams({required this.startSum, required this.limitSum, required this.minBetStep});

  factory BetParams.fromJson(Map<String, dynamic> json) => _$BetParamsFromJson(json);
  Map<String, dynamic> toJson() => _$BetParamsToJson(this);
}