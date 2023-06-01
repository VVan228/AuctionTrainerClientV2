
import 'package:auction_trainer_client_v2/security/model/BetParams.dart';
import 'package:auction_trainer_client_v2/security/model/ParticipantBet.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Lot.g.dart';

@JsonSerializable()
class Lot {
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  Status status;
  int duration;
  bool autoend;
  int intervalId;
  String name;
  String description;
  BetParams betParams;
  ParticipantBet? winner;

  Lot({required this.status, required this.duration, required this.autoend, required this.intervalId,
    required this.name, required this.description, required this.betParams, this.winner});

  factory Lot.fromJson(Map<String, dynamic> json) => _$LotFromJson(json);
  Map<String, dynamic> toJson() => _$LotToJson(this);

  static Status _statusFromJson(String status) {
    return statusFromString(status);
  }

  static String _statusToJson(Status status) {
    return status.toString();
  }
}