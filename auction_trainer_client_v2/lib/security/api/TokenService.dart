
import 'package:auction_trainer_client_v2/security/impl/TokenServiceImpl.dart';
import 'package:auction_trainer_client_v2/security/model/User.dart';
import 'package:injectable/injectable.dart';

import '../model/requests/LoginRequest.dart';

abstract class TokenService {

  User getUser() {throw UnimplementedError();}
  Future<bool> isLogged() async {throw UnimplementedError();}
  Future<String?> getAccessToken() async {throw UnimplementedError();}
  Future<void> setTokens(String refreshToken, String accessToken) async {throw UnimplementedError();}
}