
import 'notifications/enums.dart';

class Interval {
  int id;
  int duration;
  Status status;
  IntervalType type;
  bool autostart;
  bool autoend;

  Interval({required this.id, required this.duration, required this.status, required this.type, required this.autostart, required this.autoend});

  factory Interval.fromJson(Map<String, dynamic> json) {
    return Interval(
            duration : json['duration'],
            status: statusFromString(json['status']),
            type: intervalTypeFromString(json['type']),
            autostart: json['autostart'],
            autoend: json['autoend'],
            id: json['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'duration': duration,
      'status': status.toString(),
      'type': type.toString(),
      'autostart': autostart,
      'autoend': autoend,
    };
  }
}