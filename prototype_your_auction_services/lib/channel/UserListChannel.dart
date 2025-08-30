import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../controller/UserController.dart';
import '../share/ConfigAPIStreamingAdmin.dart';

class UserListChannel {
  static WebSocketChannel connent() {
    String wsUrl = ConfigAPIStreamingAdmin.getUserList();
    Uri uri = Uri.parse(wsUrl);
    WebSocketChannel channel = WebSocketChannel.connect(uri);

    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "UserList"},
    };

    channel.sink.add(jsonEncode(subscription));

    UserController().fetchUserListData();

    return channel;
  }

  static void close() {
    WebSocketChannel channel = UserListChannel.connent();
    channel.sink.close();
  }
}
