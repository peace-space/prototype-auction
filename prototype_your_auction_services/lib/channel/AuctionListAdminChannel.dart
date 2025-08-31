import 'dart:convert';

import 'package:prototype_your_auction_services/controller/AuctionController.dart';
import 'package:prototype_your_auction_services/share/ConfigAPIStreamingAdmin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AuctionListAdminChannel {
  static WebSocketChannel connectAdmin() {
    String wsUrl = ConfigAPIStreamingAdmin.getAuctionList();
    Uri uri = Uri.parse(wsUrl);
    WebSocketChannel channel = WebSocketChannel.connect(uri);

    Map<String, dynamic> subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "AuctionListAdmin"},
    };

    String json = jsonEncode(subscription);

    channel.sink.add(json);

    AuctionController().fetchAuctionListAdmin();

    return channel;
  }

  static cloaseAdmin() {
    WebSocketChannel channel = AuctionListAdminChannel.connectAdmin();
    channel.sink.close();
  }
}
