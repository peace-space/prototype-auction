import 'dart:convert';

import 'package:prototype_your_auction_services/share/ConfigAPIStreamingAdmin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserListAdminModel {
  static late var id_user;
  static var first_name_users;
  static var last_name_users;
  static var phone;
  static var email;
  static var address;
  static var password;
  static var admin_status;
  static var image_profile;
  static var created_at;
  static var updated_at;
  static dynamic dataStreaming;
  static dynamic data;

  static Stream fetchStreamingUserData() async* {
    String url = ConfigAPIStreamingAdmin().getUserList();
    Uri uri = Uri.parse(url);
    final channel = WebSocketChannel.connect(uri);
    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "AAA"},
    };

    channel.sink.add(jsonEncode(subscription));

    channel.stream.listen(
      (event) async {
        print("Connected successfully.");

        var dataString = jsonDecode(event);

        if (dataString['event'] == 'App\\Events\\AuctionEvent') {
          var userData = jsonDecode(dataString['data']);
          print(userData.toString());
          dataStreaming = userData['data'];
        }
      },
      onDone: () {
        print('Connection colose');
      },
      onError: (error) {
        print('${error.toString()}');
      },
    );

    yield dataStreaming;
  }

  static dynamic getUserData() async* {
    yield data;
  }
}
