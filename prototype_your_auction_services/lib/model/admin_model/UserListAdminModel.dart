import 'dart:convert';

import 'package:prototype_your_auction_services/share/ConfigAPIStreamingAdmin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserListAdminModel {
  // static late var id_user;
  // static var first_name_users;
  // static var last_name_users;
  // static var phone;
  // static var email;
  // static var address;
  // static var password;
  // static var admin_status;
  // static var image_profile;
  // static var created_at;
  // static var updated_at;
  static Map userData = {};
  static dynamic dataStreaming;
  static dynamic data;
  static var test;

  UserListAdminModel(Map data) {
    userData = data;
  }

  static Stream fetchStreamingUserData() async* {
    String url = ConfigAPIStreamingAdmin.getUserList();
    Uri uri = Uri.parse(url);
    final channel = WebSocketChannel.connect(uri);
    // final subscription = {
    //   "event": "pusher:subscribe",
    //   "data": {"channel": "user"},
    // };
    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "user", "data": ""},
    };

    channel.sink.add(jsonEncode(subscription));

    // channel.stream.listen(
    //   (event) async {
    //     print("Connected successfully.");
    //
    //     var dataString = jsonDecode(event);
    //     print(dataString);
    //     if (dataString['event'] == 'App\\Events\\UserEvents') {
    //       var userData = jsonDecode(dataString['data']);
    //       print(userData.toString());
    //       dataStreaming = userData['data'];
    //     }
    //   },
    //   onDone: () {
    //     print('Connection colose');
    //   },
    //   onError: (error) {
    //     print('${error.toString()}');
    //   },
    // );

    yield channel.stream;
  }

  // static dynamic getUserData() async* {
  //   yield data;
  // }

  List getData() {
    try {
      // print(userData.toString());
      // if (userData['event'] == "pusher_internal:subscription_succeeded") {
      //   // print("aaaSSS${userData['data']}");
      //   userData = userData['event'];
      //   // userData = userData['data'];
      //   print("aaaaaaaaaaaaaa${userData}");
      //   // userData = jsonEncode(userData['data']) as Map;
      //   return userData['data'];
      // }
      if (userData['event'] == "App\\Events\\UserEvent") {
        // print("${userData['data']}");
        userData = jsonDecode(userData['data']);
        return userData['data'];
      }
      List error = ["กำลังโหลด..."];
      return error;
    } catch (e) {
      List error = ["${e}"];
      return error;
    }
  }
}
