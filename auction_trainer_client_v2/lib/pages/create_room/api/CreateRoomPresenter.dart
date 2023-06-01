

import 'package:auction_trainer_client_v2/security/model/CreateRoomRequest.dart';

import 'CreateRoomView.dart';

abstract class CreateRoomPresenter {
  void setView(CreateRoomView view);
  void createRoomClick(CreateRoomRequest request);

}