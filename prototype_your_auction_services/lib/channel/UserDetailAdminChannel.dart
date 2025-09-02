import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../controller/UserController.dart';
import '../share/ConfigAPIStreamingAdmin.dart';
import 'UserListAdminChannel.dart';

class UserDetailAdminChannel {
  static WebSocketChannel connent({required var id_users}) {
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

  static void close({required var id_users}) {
    WebSocketChannel channel = UserDetailAdminChannel.connent(id_users: id_users);
    channel.sink.close();
  }
}
