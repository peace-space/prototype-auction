import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../controller/UserController.dart';
import '../share/ConfigAPIStreamingAdmin.dart';
import 'UserListChannel.dart';

class UserDetailChannel {
  static WebSocketChannel connent(var id_users) {
    String wsUrl = ConfigAPIStreamingAdmin.getUserList();
    Uri uri = Uri.parse(wsUrl);
    WebSocketChannel channel = WebSocketChannel.connect(uri);

    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "UserDetail"},
    };

    channel.sink.add(jsonEncode(subscription));

    UserController().fetchOneUserDetail(id_users: id_users);
    return channel;
  }

  static void close() {
    WebSocketChannel channel = UserListChannel.connent();
    channel.sink.close();
  }
}
