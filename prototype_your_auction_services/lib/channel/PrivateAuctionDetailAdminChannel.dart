import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../share/ConfigAPIStreamingAdmin.dart';

class PrivateAuctionDetailAdminChannel {
  static WebSocketChannel connectAdmin({required var id_auctions}) {
    String wsUrl = ConfigAPIStreamingAdmin.wsUrl;
    Uri uri = Uri.parse(wsUrl);
    WebSocketChannel channel = WebSocketChannel.connect(uri);
    Map<String, dynamic> subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "PrivateAuctionDetailAdmin"},
    };

    String json = jsonEncode(subscription);
    channel.sink.add(json);
    print("${id_auctions} <---5555555555555555555555555");

    return channel;
  }

  static closeAdmin({required var id_auctions}) {
    final channel = PrivateAuctionDetailAdminChannel.connectAdmin(id_auctions: id_auctions);
    channel.sink.close();
  }
}