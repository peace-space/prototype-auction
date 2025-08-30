import 'dart:convert';

import 'package:prototype_your_auction_services/channel/UserListChannel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserListEvent {
  WebSocketChannel pusher() {
    WebSocketChannel channel = UserListChannel.connent();
    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "UserList"},
    };

    channel.sink.add(jsonEncode(subscription));

    return channel;
  }
}
