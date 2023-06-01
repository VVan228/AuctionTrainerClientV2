
abstract class SignInView {
  void showEmailError(String? error);
  void showPasswordError(String? error);
  void showGlobalError(String? error);
  void showLoading();
  void hideLoading();
  void openMainPage();
}