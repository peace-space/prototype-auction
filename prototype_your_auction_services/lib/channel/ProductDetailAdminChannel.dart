import 'dart:convert';

import 'package:prototype_your_auction_services/controller/ProductDetailController.dart';
import 'package:prototype_your_auction_services/share/ConfigAPIStreamingAdmin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ProductDetailAdminChannel {
  static WebSocketChannel connectAdmin({required var id_auctions}) {
    String wsUrl = ConfigAPIStreamingAdmin.wsUrl;
    Uri uri = Uri.parse(wsUrl);
    WebSocketChannel channel = WebSocketChannel.connect(uri);
    Map<String, dynamic> subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "ProductDetail"},
    };

    String json = jsonEncode(subscription);
    channel.sink.add(json);
    print("${id_auctions} <---5555555555555555555555555");
    ProductDetailController().fetchProductDetail(id_auctions: id_auctions);

    return channel;
  }

  static closeAdmin({required var id_auctions}) {
    final channel = ProductDetailAdminChannel.connectAdmin(id_auctions: id_auctions);
    channel.sink.close();
  }
}
