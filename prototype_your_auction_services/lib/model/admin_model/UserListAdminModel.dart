import 'dart:async';
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
  static Map user_list_data = {};
  static dynamic dataStreaming;
  static dynamic data;

  // static var test;
  static var one_user_detail;

  // UserListAdminModel(Map data) {
  //   user_list_data = data;
  // }

  static WebSocketChannel fetchStreamingUserData() {
    String url = ConfigAPIStreamingAdmin.getUserList();
    Uri uri = Uri.parse(url);
    final channel = WebSocketChannel.connect(uri);
    // final subscription = {
    //   "event": "pusher:subscribe",
    //   "data": {"channel": "user"},
    // };
    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "user"},
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

    return channel;
  }

  void setUserListData(dynamic user_list_data) {
    UserListAdminModel.user_list_data = user_list_data;
  }

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
      if (user_list_data['event'] == "App\\Events\\UserEvent") {
        // print("${userData['data']}");
        user_list_data = jsonDecode(user_list_data['data']);
        return user_list_data['data'];
      }
      List error = ["กำลังโหลด..."];
      return error;
    } catch (e) {
      List error = ["${e}"];
      return error;
    }
  }

  void setOneUserDetail(var one_user_detial) {
    UserListAdminModel.one_user_detail = one_user_detial;
  }

  static Map getOneUserDetail() {
    // print("${one_user_detail.toString()}----------------------------");

    return one_user_detail;
  }

  void setConvertData(var data) {}

  Stream test(test) async* {
    yield test;
  }
}
