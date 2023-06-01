

import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/create_room/api/CreateRoomPresenter.dart';
import 'package:auction_trainer_client_v2/pages/create_room/api/CreateRoomView.dart';
import 'package:auction_trainer_client_v2/security/api/ServerDataProvider.dart';
import 'package:auction_trainer_client_v2/security/model/CreateRoomRequest.dart';
import 'package:auction_trainer_client_v2/security/web/RoomWebService.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: CreateRoomPresenter)
class CreateRoomPresenterImpl implements CreateRoomPresenter {

  CreateRoomView? view;

  @override
  void createRoomClick(CreateRoomRequest request) async {
    if(request.name.isEmpty) {
      view?.showError("Name is empty");
      return;
    }
    for(int i = 0; i<request.lots.length; i++) {
      if(request.lots[i].isEmpty) {
        view?.showError("Round ${i+1} is empty");
        return;
      }
    }

    final client = RoomWebService(
        await getIt<ServerDataProvider>().getDioInstance(true),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl()
    );
    
    client.createFromTemplate(request)
        .then((value) => view?.showError("Created room: ${value}"))
        .catchError((err){view?.showError(err.toString());});
  }

  @override
  void setView(CreateRoomView view) {
    this.view = view;
  }

}