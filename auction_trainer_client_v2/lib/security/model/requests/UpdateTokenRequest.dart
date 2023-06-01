
import 'package:json_annotation/json_annotation.dart';

part 'UpdateTokenRequest.g.dart';
@JsonSerializable()
class UpdateTokenRequest {
  String refreshToken;

  UpdateTokenRequest({required this.refreshToken});

  factory UpdateTokenRequest.fromJson(Map<String, dynamic> json) {
    return UpdateTokenRequest(
      refreshToken: json['refresh_token']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh_token': refreshToken,
    };
  }
}