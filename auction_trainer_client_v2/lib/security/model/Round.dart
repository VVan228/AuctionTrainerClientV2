
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Lot.dart';

part 'Round.g.dart';

@JsonSerializable()
class Round {
  bool ascending;

  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  Status status;

  List<Lot> lots;
  int intervalId;

  Round({required this.intervalId, required this.lots, required this.ascending, required this.status});

  factory Round.fromJson(Map<String, dynamic> json) => _$RoundFromJson(json);
  Map<String, dynamic> toJson() => _$RoundToJson(this);

  static Status _statusFromJson(String status) {
    return statusFromString(status);
  }

  static String _statusToJson(Status status) {
    return status.toString();
  }
}