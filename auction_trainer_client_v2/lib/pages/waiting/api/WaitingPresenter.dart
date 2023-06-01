

import 'package:auction_trainer_client_v2/security/model/Room.dart';

import 'WaitingView.dart';

abstract class WaitingPresenter {
  void setView(WaitingView view);
  void setRoom(Room room);
  void dispose();
  void joinClick();
  void leaveClick();
  void sendNextPoint();
}
