import 'dart:convert';

import 'package:prototype_your_auction_services/controller/AuctionController.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../share/ConfigAPIStreamingAdmin.dart';

class MyAuctionChannel {
  static dynamic channel;

  WebSocketChannel connect({required var id_users, required var id_product_types, required String key_word}) {
    String wsUrl = ConfigAPIStreamingAdmin.wsUrl;
    Uri uri = Uri.parse(wsUrl);
    channel = WebSocketChannel.connect(uri);

    Map<String, dynamic> subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "MyAuctions"},
    };

    String json = jsonEncode(subscription);

    channel.sink.add(json);

    AuctionController().myAuctionSelectTypes(id_users: id_users, id_products: id_product_types, key_word: key_word);

    return channel;
  }

  static void close() {
    // WebSocketChannel channel = MyAuctionChannel().connect(id_products: null, key_word: '');

    channel.sink.close();
  }
}