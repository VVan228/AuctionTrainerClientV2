


import 'package:auction_trainer_client_v2/security/model/requests/LoginRequest.dart';
import 'package:auction_trainer_client_v2/security/model/requests/RegisterRequest.dart';
import 'package:auction_trainer_client_v2/security/model/requests/TokenResponse.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/requests/UpdateTokenRequest.dart';

part 'AuctionWebService.g.dart';
@RestApi()
abstract class AuctionWebService {
  factory AuctionWebService(Dio dio, {String baseUrl}) = _AuctionWebService;

  @POST('auction/nextPoint')
  Future<void> nextPoint(@Query("roomId") int roomId);

}