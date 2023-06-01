

import 'package:auction_trainer_client_v2/security/model/ParticipantBet.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/enums.dart';

abstract class AuctionView {
  void updateRoundStatus(int i, Status status);
  void updateLotStatus(int i, int j, Status status);
  void updateLotWinner(int i, int j, ParticipantBet? bet);
  void showError(String error);
  void updateRoomStatus(Status status);
  void updateBet(int intervalId, int? bet);
}