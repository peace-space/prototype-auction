import 'dart:convert';

import 'package:prototype_your_auction_services/share/ConfigAPIStreamingAdmin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserPrivateAuctionAdminChannel {
  static WebSocketChannel connect() {
    String wsUrl = ConfigAPIStreamingAdmin.wsUrl;
    Uri uri = Uri.parse(wsUrl);
    WebSocketChannel channel = WebSocketChannel.connect(uri);

    Map<String, dynamic> subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "PrivateAuctionAdmin"},
    };

    String json = jsonEncode(subscription);

    channel.sink.add(json);

    return channel;
  }

  static void close() {
    WebSocketChannel channel = UserPrivateAuctionAdminChannel.connect();
    channel.sink.close();
  }
}
