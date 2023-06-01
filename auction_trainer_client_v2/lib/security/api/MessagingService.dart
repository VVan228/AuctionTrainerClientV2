
import 'package:centrifuge/centrifuge.dart' as centrifuge;

abstract class MessagingService{
  void connect(void Function(dynamic event)? onEvent) async {throw UnimplementedError();}
  void unsubscribe(String channel) async {throw UnimplementedError();}
  Future<void> subscribe({required String channel}) async {throw UnimplementedError();}
  void setListeners({
    required String channel,
    required void Function(centrifuge.PublicationEvent event) onPublication,
    void Function(centrifuge.SubscribedEvent event)? onSubscribed,
    void Function(centrifuge.UnsubscribedEvent event)? onUnsubscribed,
    void Function(centrifuge.SubscriptionErrorEvent event)? onError,
    void Function(centrifuge.JoinEvent event)? onJoin,
    void Function(centrifuge.LeaveEvent event)? onLeave,
  }) {throw UnimplementedError();}
  Future<List<String>> getPresence(String channel) async{throw UnimplementedError();}
  Stream<dynamic> connectEvents(){throw UnimplementedError();}
  void removeListeners(String channel);
}