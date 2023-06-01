

abstract class SignUpView {
  void showEmailError(String? error);
  void showUsernameError(String? error);
  void showPasswordError(String? error);
  void showGlobalError(String? error);
  void showLoading();
  void hideLoading();
  void openMainPage();
}