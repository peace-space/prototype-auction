import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../controller/AuctionController.dart';
import '../share/ConfigAPIStreamingAdmin.dart';

class AuctionHomeChannel {
  static WebSocketChannel connect({required id_products, key_word}) {
    String wsUrl = ConfigAPIStreamingAdmin.wsUrl;
    Uri uri = Uri.parse(wsUrl);

    WebSocketChannel channel = WebSocketChannel.connect(uri);

    Map<String, dynamic> subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "AuctionList"},
    };

    String json = jsonEncode(subscription);

    channel.sink.add(json);

    AuctionController().fetchAuctionSelectTypes(id_products: id_products, key_word: key_word);
    
    return channel;
  }

}