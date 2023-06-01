
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String email;
  String username;

  User({required this.email, required this.username});


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);


// factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     email: json['email'],
  //     username: json['username'],
  //     id: json['id'],
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'email': email,
  //     'username': username,
  //     'id': id,
  //   };
  // }
}