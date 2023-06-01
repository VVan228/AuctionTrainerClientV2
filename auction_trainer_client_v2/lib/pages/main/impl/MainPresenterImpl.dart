

import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/main.dart';
import 'package:auction_trainer_client_v2/pages/main/api/MainPresenter.dart';
import 'package:auction_trainer_client_v2/pages/main/api/MainView.dart';
import 'package:auction_trainer_client_v2/security/api/MessagingService.dart';
import 'package:auction_trainer_client_v2/security/api/ServerDataProvider.dart';
import 'package:auction_trainer_client_v2/security/model/Room.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';
import 'package:auction_trainer_client_v2/security/web/RoomWebService.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MainPresenter)
class MainPresenterImpl implements MainPresenter{

  MainView? mainView;

  @override
  void roomIdEntered(String roomId) async {
    if(roomId.isEmpty) return;

    final client = RoomWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );

    Room? room = await client.get(int.parse(roomId)).catchError((Object obj) {
      print("err" + obj.toString());
      return null;
    });
    print(room.toString());
    if(room!=null) {
      if(room.status == Status.SAVED) {
        mainView?.openWaitPage(room);
        return;
      }
      getIt<MessagingService>().subscribe(channel: getIt<ServerDataProvider>().getChannelName(room.id, false));
      mainView?.openAuctionPage(room);
    }
  }

  @override
  void setView(MainView view) {
    mainView = view;
  }

  @override
  void createClick() {
    mainView?.openCreatePage();
  }

}