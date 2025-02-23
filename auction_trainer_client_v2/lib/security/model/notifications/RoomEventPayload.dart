import 'package:auction_trainer_client_v2/security/model/notifications/Payload.dart';

import '../Interval.dart';
import 'enums.dart';

class RoomEventPayload extends Payload {
  Status roomStatus;
  List<Interval> intervalsStarted;
  List<Interval> intervalsEnded;

  RoomEventPayload(
      {required String type,
      required this.roomStatus,
      required this.intervalsStarted,
      required this.intervalsEnded})
      : super(type: type);

  factory RoomEventPayload.fromJson(Map<String, dynamic> json) {
    return RoomEventPayload(
      roomStatus: statusFromString(json['roomStatus']),
      type: json['type'],
      intervalsStarted: List<Interval>.from(
          json['intervalsStarted'].map((x) => Interval.fromJson(x))),
      intervalsEnded: List<Interval>.from(
          json['intervalsEnded'].map((x) => Interval.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'roomStatus': roomStatus,
      'intervalsStarted': List<Map<String, dynamic>>.from(
          intervalsStarted.map((e) => e.toJson())),
      'intervalsEnded': List<Map<String, dynamic>>.from(
          intervalsEnded.map((e) => e.toJson())),
    };
  }
}
