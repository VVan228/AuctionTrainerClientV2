

import 'dart:convert';

import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/auction/api/AuctionPresenter.dart';
import 'package:auction_trainer_client_v2/pages/auction/api/AuctionView.dart';
import 'package:auction_trainer_client_v2/security/api/MessagingService.dart';
import 'package:auction_trainer_client_v2/security/api/ServerDataProvider.dart';
import 'package:auction_trainer_client_v2/security/model/Room.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/RoomEventPayload.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';
import 'package:auction_trainer_client_v2/security/web/AuctionWebService.dart';
import 'package:auction_trainer_client_v2/security/web/RoomWebService.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as:AuctionPresenter)
class AuctionPresenterImpl implements AuctionPresenter{

  AuctionView? view;
  Room? thisRoom;

  @override
  void makeBet(int intervalId, int sum) async {
    final client = RoomWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );

    try {
      client.makeBet(intervalId, sum).then((value) => view?.updateBet(intervalId, sum)).catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            final res = (obj as DioError).response;
            String? resStr = res?.data['message'].toString();
            view?.showError(resStr ?? "error");
            view?.updateBet(intervalId, null);
            break;
          default:
            break;
        }
      });
    }catch(e){
      view?.showError(e.toString());
    }
  }

  @override
  void setRoom(Room room) async {
    thisRoom = room;

    Map<int, List<int>> lotKeys = {};
    Map<int, int> roundKeys = {};

    for(int i = 0; i<room.rounds.length; i++) {
      roundKeys[room.rounds[i].intervalId] = i;
      for(int j = 0; j<room.rounds[i].lots.length; j++){
        lotKeys[room.rounds[i].lots[j].intervalId] = [i, j];
      }
    }

    final client = RoomWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );


    MessagingService messagingService = getIt<MessagingService>();
    ServerDataProvider serverDataProvider = getIt<ServerDataProvider>();
    messagingService.setListeners(
        channel: serverDataProvider.getChannelName(room.id, false),
        onPublication: (event) {
          print("evemt!");
          var j = json.decode(utf8.decode(event.data, allowMalformed: true));
          var payload = j['payload'];
          switch(payloadTypeFromString(payload['type'])) {
            case PayloadType.RoomEvent : {
              var event = RoomEventPayload.fromJson(payload);
              for(var endEvent in event.intervalsEnded) {
                if(endEvent.type == IntervalType.ROUND && roundKeys[endEvent.id]!=null) {
                  view?.updateRoundStatus(roundKeys[endEvent.id]!, Status.ENDED);
                }
                if(endEvent.type == IntervalType.LOT && lotKeys[endEvent.id]!=null) {
                  view?.updateLotStatus(
                      lotKeys[endEvent.id]![0], lotKeys[endEvent.id]![1], Status.ENDED);
                  client.getResult(endEvent.id).then((value) =>
                      view?.updateLotWinner(lotKeys[endEvent.id]![0], lotKeys[endEvent.id]![1], value));
                }
              }

              for(var startEvent in event.intervalsStarted) {
                if(startEvent.type == IntervalType.ROUND && roundKeys[startEvent.id]!=null) {
                  view?.updateRoundStatus(roundKeys[startEvent.id]!, Status.ONGOING);
                }
                if(startEvent.type == IntervalType.LOT && lotKeys[startEvent.id]!= null) {
                  view?.updateLotStatus(
                      lotKeys[startEvent.id]![0], lotKeys[startEvent.id]![1], Status.ONGOING);
                }
              }
              if(event.roomStatus == Status.ENDED) {
                view?.updateRoomStatus(event.roomStatus);
              }
            }

          }

        });
  }

  @override
  void setView(AuctionView view) {
    this.view = view;
  }

  @override
  void dispose() {
    if(thisRoom == null){
      return;
    }
    ServerDataProvider provider = getIt<ServerDataProvider>();
    MessagingService messagingService = getIt<MessagingService>();
    String channel = provider.getChannelName(thisRoom!.id, false);
    messagingService.unsubscribe(channel);
  }

  @override
  void sendNextPoint() async {
    if(thisRoom==null) {
      return;
    }
    final client = AuctionWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );
    client.nextPoint(thisRoom!.id).catchError((value) => view?.showError(value.toString()));

  }

}