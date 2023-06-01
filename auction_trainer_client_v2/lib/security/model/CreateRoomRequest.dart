


import 'package:auction_trainer_client_v2/security/model/LotRequest.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'LotRequest.dart';

part 'CreateRoomRequest.g.dart';

@JsonSerializable()
class CreateRoomRequest {
  String name;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime? startTime;
  int templateId;
  List<List<LotRequest>> lots;

  CreateRoomRequest({required this.name,   this.startTime, required this.templateId, required this.lots});

  factory CreateRoomRequest.fromJson(Map<String, dynamic> json) => _$CreateRoomRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateRoomRequestToJson(this);

  static DateTime? _fromJson(String? startTime) {
    if(startTime == null) return null;
    return DateTime.parse(startTime);
  }

  static String? _toJson(DateTime? startTime) {
    if(startTime == null) return null;
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(startTime);
  }

}