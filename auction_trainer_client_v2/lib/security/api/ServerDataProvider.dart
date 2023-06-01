

import 'package:dio/dio.dart';

abstract class ServerDataProvider {
  Future<Dio> getDioInstance(bool auth);
  String getBaseUrl();
  String getMessagingUrl();
  String getChannelName(int roomId, bool admin);
}