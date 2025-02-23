import 'package:auction_trainer_client_v2/security/api/ServerDataProvider.dart';
import 'package:auction_trainer_client_v2/security/api/TokenService.dart';
import 'package:auction_trainer_client_v2/security/model/requests/TokenResponse.dart';
import 'package:auction_trainer_client_v2/security/web/AuthWebService.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../inject_config/DependenciesConfiguration.dart';
import '../model/User.dart';
import '../model/requests/UpdateTokenRequest.dart';

@Singleton(as: TokenService)
class TokenServiceImpl implements TokenService {
  static SharedPreferences? prefs;

  static TokenServiceImpl? obj;

  Map<String, String?> tokens = {};

  User? user;

  @PostConstruct()
  void init() {
    print("shared pref");
    SharedPreferences.getInstance().then((value) => prefs = value);
  }

  Future<Map<String, String?>> getTokens() async {
    if (tokens['refresh_token'] != null && tokens['access_token'] != null) {
      return tokens;
    }
    Map<String, String?> res = {
      "refresh_token": prefs?.getString('refresh_token'),
      "access_token": prefs?.getString('access_token')
    };
    tokens = res;
    return res;
  }

  @override
  Future<void> setTokens(String refreshToken, String accessToken) async {
    prefs?.setString('refresh_token', refreshToken);
    prefs?.setString('access_token', accessToken);

    print(JwtDecoder.decode(accessToken));
    user = User(
        email: JwtDecoder.decode(accessToken)['email'],
        username: JwtDecoder.decode(accessToken)['sub']);

    tokens["refresh_token"] = prefs?.getString('refresh_token');
    tokens["access_token"] = prefs?.getString('access_token');
  }

  @override
  Future<bool> isLogged() async {
    tokens = await getTokens();
    String refreshToken = tokens["refresh_token"] ?? "";
    String accessToken = tokens["access_token"] ?? "";

    bool res = refreshToken.isNotEmpty &&
        accessToken.isNotEmpty &&
        !JwtDecoder.isExpired(refreshToken);

    if (res) {
      user = User(
          email: JwtDecoder.decode(accessToken)['email'],
          username: JwtDecoder.decode(accessToken)['sub']);
    }
    return res;
  }

  @override
  Future<String?> getAccessToken() async {
    tokens = await getTokens();
    String refreshToken = tokens["refresh_token"] ?? "";
    String accessToken = tokens["access_token"] ?? "";
    if (!JwtDecoder.isExpired(accessToken)) {
      return accessToken;
    } else if (!JwtDecoder.isExpired(refreshToken)) {
      final client = AuthWebService(
          await getIt<ServerDataProvider>().getDioInstance(false),
          baseUrl: getIt<ServerDataProvider>().getBaseUrl());

      UpdateTokenRequest utr = UpdateTokenRequest(refreshToken: refreshToken);

      TokenResponse response = await client.updateToken(utr);
      if (response.accessToken.isNotEmpty && response.refreshToken.isNotEmpty) {
        setTokens(response.refreshToken, response.accessToken);
      }

      return tokens['access_token'];
    }
    return null;
  }

  @override
  User getUser() {
    return user ?? User(email: "", username: "");
  }
}
