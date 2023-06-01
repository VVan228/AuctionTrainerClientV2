

import '../model/requests/LoginRequest.dart';
import '../model/requests/RegisterRequest.dart';

abstract class AuthService {
  Future<void> register(RegisterRequest request) async {throw UnimplementedError();}
  Future<void> login(LoginRequest request) async {throw UnimplementedError();}
}