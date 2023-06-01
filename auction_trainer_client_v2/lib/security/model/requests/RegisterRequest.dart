
import 'package:json_annotation/json_annotation.dart';

part 'RegisterRequest.g.dart';
@JsonSerializable()
class RegisterRequest {
  String email;
  String password;
  String username;

  RegisterRequest({required this.email,required this.password, required this.username});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      email: json['email'],
      password: json['password'],
      username: json['username']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
    };
  }
}