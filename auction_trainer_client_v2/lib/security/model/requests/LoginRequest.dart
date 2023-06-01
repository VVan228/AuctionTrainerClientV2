
import 'package:json_annotation/json_annotation.dart';

part 'LoginRequest.g.dart';
@JsonSerializable()
class LoginRequest {
  String email;
  String password;

  LoginRequest({required this.email,required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}