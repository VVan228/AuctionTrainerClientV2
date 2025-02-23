import 'package:auction_trainer_client_v2/security/api/AuthService.dart';
import 'package:auction_trainer_client_v2/security/model/requests/LoginRequest.dart';
import 'package:auction_trainer_client_v2/security/model/requests/RegisterRequest.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../inject_config/DependenciesConfiguration.dart';
import '../api/ServerDataProvider.dart';
import '../api/TokenService.dart';
import '../web/AuthWebService.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  @override
  Future<void> login(LoginRequest request) async {
    final client = AuthWebService(
        await getIt<ServerDataProvider>().getDioInstance(false),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl());

    String? error;

    await client.login(request).then((value) {
      getIt<TokenService>().setTokens(value.refreshToken, value.accessToken);
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError);
          error = res.response?.data['message'];
          throw Exception(error);
        default:
          error = "wtf";
          break;
      }
    });

    if (error != null) {
      throw Exception(error);
    }
  }

  @override
  Future<void> register(RegisterRequest request) async {
    final client = AuthWebService(
        await getIt<ServerDataProvider>().getDioInstance(false),
        baseUrl: getIt<ServerDataProvider>().getBaseUrl());

    String? error;

    await client.register(request).then((value) {
      getIt<TokenService>().setTokens(value.refreshToken, value.accessToken);
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError);
          error = res.response?.data['message'];
          throw Exception(error);
        default:
          error = "wtf";
          break;
      }
    });

    if (error != null) {
      throw Exception(error);
    }
  }
}
