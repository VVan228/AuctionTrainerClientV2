
import 'package:auction_trainer_client_v2/security/model/Room.dart';

abstract class MainView{
  void showErrorMsg(String error);
  void openWaitPage(Room room);
  void openAuctionPage(Room room);
  void openCreatePage();
}