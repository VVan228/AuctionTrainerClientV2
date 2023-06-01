

import 'MainView.dart';

abstract class MainPresenter{
  void roomIdEntered(String roomId);
  void createClick();
  void setView(MainView view);
}