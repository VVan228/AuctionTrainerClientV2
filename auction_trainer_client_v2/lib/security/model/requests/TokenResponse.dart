
import 'package:json_annotation/json_annotation.dart';

part 'TokenResponse.g.dart';
@JsonSerializable()
class TokenResponse {
  String email;
  String accessToken;
  String refreshToken;

  TokenResponse({required this.email, required this.accessToken, required this.refreshToken});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      email: json['email'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}