
import 'package:auction_trainer_client_v2/security/model/BetParams.dart';
import 'package:auction_trainer_client_v2/security/model/ParticipantBet.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LotRequest.g.dart';

@JsonSerializable()
class LotRequest {
  int? duration;
  String name;
  String description;
  BetParams? betParams;

  LotRequest({required this.duration, required this.name, required this.description, required this.betParams});

  factory LotRequest.fromJson(Map<String, dynamic> json) => _$LotRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LotRequestToJson(this);

}