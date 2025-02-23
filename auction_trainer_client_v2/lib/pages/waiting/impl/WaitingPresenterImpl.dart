import 'dart:convert';

import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/waiting/api/WaitingPresenter.dart';
import 'package:auction_trainer_client_v2/pages/waiting/api/WaitingView.dart';
import 'package:auction_trainer_client_v2/security/api/MessagingService.dart';
import 'package:auction_trainer_client_v2/security/api/ServerDataProvider.dart';
import 'package:auction_trainer_client_v2/security/model/Room.dart';
import 'package:auction_trainer_client_v2/security/model/User.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/RoomEventPayload.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';
import 'package:auction_trainer_client_v2/security/web/AuctionWebService.dart';
import 'package:auction_trainer_client_v2/security/web/RoomWebService.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WaitingPresenter)
class WaitingPresenterImpl implements WaitingPresenter {
  WaitingView? view;
  Room? room;

  ServerDataProvider provider = getIt<ServerDataProvider>();
  MessagingService messagingService = getIt<MessagingService>();

  @override
  void setRoom(Room room) {
    this.room = room;
    String channel = provider.getChannelName(room.id, false);
    for (User u in room.connectedUsers) {
      view?.addParticipant(u.username);
    }

    messagingService.subscribe(channel: channel);
    messagingService.setListeners(
        channel: channel,
        onPublication: (event) {
          var j = json.decode(utf8.decode(event.data, allowMalformed: true));
          var payload = j['payload'];

          switch (payloadTypeFromString(payload['type'])) {
            case PayloadType.UserLeft:
              {
                view?.removeParticipant(payload['username']);
                room.connectedUsers
                    .remove(User(username: payload['username'], email: ""));
                break;
              }
            case PayloadType.UserJoined:
              {
                view?.addParticipant(payload['username']);
                room.connectedUsers
                    .add(User(username: payload['username'], email: ""));
                break;
              }
            case PayloadType.RoomEvent:
              {
                messagingService.unsubscribe(channel);
                //TODO: Remove
                //room.rounds[0].status = Status.ONGOING;
                //room.rounds[0].lots[1].status = Status.ONGOING;
                var event = RoomEventPayload.fromJson(payload);
                if (event.intervalsEnded.isEmpty) {
                  room.status = Status.ONGOING;
                  for (var i in event.intervalsStarted) {
                    if (i.type == IntervalType.ROUND) {
                      room.rounds[0].status = i.status;
                    }
                    if (i.type == IntervalType.LOT) {
                      room.rounds[0].lots[0].status = i.status;
                    }
                  }
                }

                view?.openRoom(room);
              }
          }
        },
        onJoin: (event) {
          view?.addWatcher(event.user);
        },
        onLeave: (event) {
          view?.removeWatcher(event.user);
        });

    if (room.startTime != null) {
      view?.setClock(room.startTime!.millisecondsSinceEpoch);
    } else {
      view?.setClock(0);
    }

    messagingService.getPresence(channel).then((value) {
      for (String u in value) {
        view?.addWatcher(u);
      }
    });
  }

  @override
  void setView(WaitingView view) {
    this.view = view;
  }

  @override
  void joinClick() async {
    final client = RoomWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl());
    if (room?.id != null) {
      client.joinRoom(room?.id ?? 0);
    }
  }

  @override
  void leaveClick() async {
    final client = RoomWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl());
    if (room?.id != null) {
      client.leaveRoom(room?.id ?? 0);
    }
  }

  @override
  void dispose() {
    if (room == null) {
      return;
    }
    ServerDataProvider provider = getIt<ServerDataProvider>();
    MessagingService messagingService = getIt<MessagingService>();
    String channel = provider.getChannelName(room!.id, false);
    messagingService.unsubscribe(channel);
  }

  @override
  void sendNextPoint() async {
    if (room == null) {
      return;
    }
    final client = AuctionWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl());
    client.nextPoint(room!.id);
  }
}
