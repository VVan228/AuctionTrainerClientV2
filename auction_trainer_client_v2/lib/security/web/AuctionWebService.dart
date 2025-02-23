import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'AuctionWebService.g.dart';

@RestApi()
abstract class AuctionWebService {
  factory AuctionWebService(Dio dio, {String baseUrl}) = _AuctionWebService;

  @POST('auction/nextPoint')
  Future<void> nextPoint(@Query("roomId") int roomId);
}
