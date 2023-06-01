

class Payload {
  String type;

  Payload({required this.type});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}