
import 'package:auction_trainer_client_v2/security/model/CreateRoomRequest.dart';
import 'package:auction_trainer_client_v2/security/model/ParticipantBet.dart';
import 'package:auction_trainer_client_v2/security/model/Room.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'RoomWebService.g.dart';

@RestApi()
abstract class RoomWebService {
  factory RoomWebService(Dio dio, {String baseUrl}) = _RoomWebService;

  @GET('room/get')
  Future<Room?> get(@Query("roomId") int roomId);

  @GET('room/join')
  Future<void> joinRoom(@Query("roomId") int roomId);


  @GET('room/leave')
  Future<void> leaveRoom(@Query("roomId") int roomId);

  @POST('room/makeBet')
  Future<void> makeBet(@Query("intervalId") int intervalId, @Query("sum") int sum);

  @GET('room/getResult')
  Future<ParticipantBet?> getResult(@Query("intervalId") int intervalId);

  @POST('room/createFromTemplate')
  Future<int> createFromTemplate(@Body() CreateRoomRequest request);

}