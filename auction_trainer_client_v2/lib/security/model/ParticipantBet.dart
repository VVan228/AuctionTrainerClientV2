
import 'package:json_annotation/json_annotation.dart';

part 'ParticipantBet.g.dart';

@JsonSerializable()
class ParticipantBet{
  String username;
  int sum;

  ParticipantBet({required this.username, required this.sum});

  factory ParticipantBet.fromJson(Map<String, dynamic> json) => _$ParticipantBetFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantBetToJson(this);
}