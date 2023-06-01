

import 'package:auction_trainer_client_v2/security/model/User.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Round.dart';

part 'Room.g.dart';

@JsonSerializable()
class Room {
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime? startTime;
  User creator;
  String name;
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  Status status;
  int id;
  List<Round> rounds;
  List<User> connectedUsers;

  Room({required this.connectedUsers, this.startTime, required this.rounds, required this.creator, required this.name, required this.status, required this.id});

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RoomToJson(this);
  //
  // factory Room.fromJson(Map<String, dynamic> json) {
  //   return Room(
  //     startTime: json['startTime'],
  //     creator: json['creator'],
  //     name: json['name'],
  //     status: json['status'],
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'startTime': startTime,
  //     'creator': creator,
  //     'name': name,
  //     'status': status,
  //   };
  // }

  static DateTime? _fromJson(String? startTime) {
    if(startTime == null) return null;
    return DateTime.parse(startTime);
  }

  static String? _toJson(DateTime? startTime) {
    if(startTime == null) return null;
    return startTime.toString();
  }

  static Status _statusFromJson(String status) {
    return statusFromString(status);
  }

  static String _statusToJson(Status status) {
    return status.toString();
  }
}