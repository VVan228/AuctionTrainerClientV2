

import 'package:auction_trainer_client_v2/security/model/requests/LoginRequest.dart';
import 'package:auction_trainer_client_v2/security/model/requests/RegisterRequest.dart';
import 'package:auction_trainer_client_v2/security/model/requests/TokenResponse.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/requests/UpdateTokenRequest.dart';

part 'AuthWebService.g.dart';
@RestApi()
abstract class AuthWebService {
  factory AuthWebService(Dio dio, {String baseUrl}) = _AuthWebService;

  @POST('auth/login')
  Future<TokenResponse> login(@Body() LoginRequest request);

  @POST('auth/register')
  Future<TokenResponse> register(@Body() RegisterRequest request);

  @POST('auth/updateToken')
  Future<TokenResponse> updateToken(@Body() UpdateTokenRequest request);
}