

import 'package:auction_trainer_client_v2/pages/auction/api/AuctionView.dart';
import 'package:auction_trainer_client_v2/security/model/Room.dart';

abstract class AuctionPresenter {
  void makeBet(int intervalId, int sum);
  void setView(AuctionView view);
  void setRoom(Room room);
  void sendNextPoint();
  void dispose();
}