import 'dart:convert';

import 'package:prototype_your_auction_services/share/ConfigAPIStreamingAdmin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Broadcasting {
  var data;

  Stream connect() async* {
    print("stat");
    String ws = ConfigAPIStreamingAdmin.getUserList();
    print("${ws}");
    Uri uri = Uri.parse(ws);
    final channel = WebSocketChannel.connect(uri);
    final subscribe = {
      {"event": "App\\Events\\UserEvent", "channel": "user"},
    };
    channel.sink.add(jsonEncode(subscribe));

    channel.stream.listen(
      (event) async {
        print("Connection Sucessfully.");
        print("${event}");
        data = jsonDecode(event);
      },
      onError: (error) {
        print("${error}");
      },
      onDone: () {
        print("Connection done.");
      },
    );
  }
}
