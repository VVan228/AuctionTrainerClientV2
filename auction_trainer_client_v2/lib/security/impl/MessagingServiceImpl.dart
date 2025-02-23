import 'dart:async';
import 'dart:convert';

import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/security/api/ServerDataProvider.dart';
import 'package:auction_trainer_client_v2/security/api/TokenService.dart';
import 'package:auction_trainer_client_v2/security/model/notifications/RoomEventPayload.dart';
import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:injectable/injectable.dart';

import '../api/MessagingService.dart';

@LazySingleton(as: MessagingService)
class MessagingServiceImpl implements MessagingService {
  centrifuge.Client? client;
  final StreamController<dynamic> _connectEventsController =
      StreamController<dynamic>.broadcast(sync: true);

  @override
  Stream<dynamic> connectEvents() => _connectEventsController.stream;

  Map<String, centrifuge.Subscription?> subscription = {};

  StreamSubscription<centrifuge.SubscribedEvent>? onSubscribedListener;
  StreamSubscription<centrifuge.PublicationEvent>? onPublicationListener;
  StreamSubscription<centrifuge.UnsubscribedEvent>? onUnsubscribedListener;
  StreamSubscription<centrifuge.SubscriptionErrorEvent>? onErrorListener;
  StreamSubscription<centrifuge.JoinEvent>? onJoinListener;
  StreamSubscription<centrifuge.LeaveEvent>? onLeaveListener;

  @PostConstruct()
  void init() {
    connect((event) {
      _connectEventsController.add(event);
    });
  }

  @override
  void connect(void Function(dynamic event)? onEvent) async {
    //String? token = await getIt<TokenService>().getAccessToken();
    //print(token);

    client = centrifuge.createClient(
        getIt<ServerDataProvider>().getMessagingUrl() +
            "connection/websocket?format=protobuf",
        centrifuge.ClientConfig(getToken: (event) {
      return getIt<TokenService>()
          .getAccessToken()
          .then((value) => value ?? "");
    }));

    client?.connecting.listen(onEvent);
    client?.connected.listen(onEvent);
    client?.disconnected.listen(onEvent);
    client?.connect();
  }

  @override
  Future<void> subscribe({required String channel}) async {
    if (subscription[channel] != null) {
      print('has sub');
      return;
    }
    print('no sub');
    subscription[channel] = client?.newSubscription(
        channel, centrifuge.SubscriptionConfig(joinLeave: true));

    subscription[channel]?.subscribe();
  }

  @override
  Future<List<String>> getPresence(String channel) async {
    List<String> users = [];

    var res = await subscription[channel]?.presence();
    if (res != null) {
      for (centrifuge.ClientInfo u in res.clients.values) {
        users.add(u.user);
      }
    }
    return users;
  }

  @override
  void removeListeners(String channel) {
    subscription[channel]?.unsubscribe();
  }

  @override
  void setListeners({
    required String channel,
    required void Function(centrifuge.PublicationEvent event) onPublication,
    void Function(centrifuge.SubscribedEvent event)? onSubscribed,
    void Function(centrifuge.UnsubscribedEvent event)? onUnsubscribed,
    void Function(centrifuge.SubscriptionErrorEvent event)? onError,
    void Function(centrifuge.JoinEvent event)? onJoin,
    void Function(centrifuge.LeaveEvent event)? onLeave,
  }) {
    // if(subscription[channel] == null) {
    //   subscribe(channel: channel);
    // }
    onSubscribedListener =
        subscription[channel]?.subscribed.listen(onSubscribed);
    onPublicationListener =
        subscription[channel]?.publication.listen(onPublication);
    onUnsubscribedListener =
        subscription[channel]?.unsubscribed.listen(onUnsubscribed);
    onErrorListener = subscription[channel]?.error.listen(onError);
    onJoinListener = subscription[channel]?.join.listen(onJoin);
    onLeaveListener = subscription[channel]?.leave.listen(onLeave);
  }

  @override
  void unsubscribe(String channel) async {
    onSubscribedListener?.cancel();
    onPublicationListener?.cancel();
    onUnsubscribedListener?.cancel();
    onErrorListener?.cancel();
    onJoinListener?.cancel();
    onLeaveListener?.cancel();
  }
}
