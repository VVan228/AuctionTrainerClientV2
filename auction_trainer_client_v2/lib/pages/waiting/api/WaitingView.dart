import 'package:auction_trainer_client_v2/security/model/Room.dart';

abstract class WaitingView {
  void addWatcher(String username);
  void removeWatcher(String username);

  void addParticipant(String user);
  void removeParticipant(String user);

  void openRoom(Room room);
  void setClock(int time);
}
