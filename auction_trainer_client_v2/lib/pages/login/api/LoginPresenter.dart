
import 'package:auction_trainer_client_v2/pages/login/api/SignInView.dart';
import 'package:auction_trainer_client_v2/pages/login/api/SignUpView.dart';

abstract class LoginPresenter {
  void login(String password, String email);
  void register(String password, String email, String username);
  void setSignInView(SignInView view);
  void setSignUpView(SignUpView view);
}