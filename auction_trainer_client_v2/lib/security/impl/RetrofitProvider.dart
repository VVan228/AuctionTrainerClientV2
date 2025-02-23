import 'package:auction_trainer_client_v2/security/api/ServerDataProvider.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../inject_config/DependenciesConfiguration.dart';
import '../api/TokenService.dart';

@LazySingleton(as: ServerDataProvider)
class RetrofitDataProvider implements ServerDataProvider {
  //String baseUrl = "http://192.168.0.102:8080/";
  //String messagingUrl = "ws://192.168.0.102:8000/";
  // String baseUrl = "http://localhost:8481/";
  // String messagingUrl = "ws://localhost:8000/";
  String baseUrl = const String.fromEnvironment('SERVER_URL', defaultValue: '');
  String messagingUrl = const String.fromEnvironment('MESSAGING_URL',
      defaultValue: 'http://localhost:8000/');

  @override
  String getBaseUrl() {
    return baseUrl;
  }

  @override
  Future<Dio> getDioInstance(bool auth) async {
    if (!auth) {
      return Dio();
    }
    Dio dio = Dio();
    String? token = await getIt<TokenService>().getAccessToken();
    dio.options.headers['Authorization'] = token;
    return dio;
  }

  @override
  String getMessagingUrl() {
    return messagingUrl;
  }

  @override
  String getChannelName(int roomId, bool admin) {
    //return "room:" + roomId.toString() + (admin?":admin":"");
    return "test";
  }
}
