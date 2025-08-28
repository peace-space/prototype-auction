import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/controller/UserController.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../share/ConfigAPIStreamingAdmin.dart';

class UserListAdmin extends StatefulWidget {
  State<UserListAdmin> createState() {
    return UserListAdminState();
  }
}

class UserListAdminState extends State<UserListAdmin> {
  static var data;

  // String ws = ConfigAPIStreamingAdmin.getUserList();
  // late Uri uri;
  var channel;

  // Map<String, dynamic> subscription = {
  //   "event": "pusher:subscribe",
  //   "data": {"channel": "user"}};
  @override
  void initState() {
    UserController().fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("stat");
    String ws = ConfigAPIStreamingAdmin.getUserList();
    print("${ws}");
    Uri uri = Uri.parse(ws);
    final channel = WebSocketChannel.connect(uri);
    Map<String, dynamic> subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "user"}};
    channel.sink.add(jsonEncode(subscription));
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการผู้ใช้งาน'),
      ),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          print("ssss: ${snapshot.data}");

          if (snapshot.hasError) {
            return Center(
              child: Text('เกิดข้อผิดพลาด'),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }


          if (snapshot.hasData) {
            var data;
            var userData;
            var dataJson = jsonDecode(snapshot.data);
            print("dataJson: ${dataJson}");
            if (dataJson['event'] == "App\\Events\\UserEvent") {
              // print("${userData['data']}");
              data = jsonDecode(dataJson['data']);
            } else if (dataJson['event'] == "pusher:ping") {
              Map<String, dynamic> subscription = {
                "event": "pusher:ping", "data": {"channel": "user"}};
              channel.sink.add(jsonEncode(subscription));
              print("::: Ping :::");
            } else if (dataJson['event'] == "pusher:pong") {
              Map<String, dynamic> subscription = {
                "event": "pusher:pong", "data": {"channel": "user"}};
              channel.sink.add(jsonEncode(subscription));
              UserController userController = UserController();
              userController.fetchUserData();
              print("::: Pong :::");
            }

            if (data == null) {
              return Center(
                child: Text("ไม่มีข้อมูล"),
              );
            } else {
              userData = data['data'];
              return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  // Map userData = data[index];
                  return Card(
                      child: InkWell(
                        onTap: () {

                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Text("${userData[index]['id_users']}: "),
                              Text("${userData[index]['first_name_users']}"),
                              Text("${userData[index]['last_name_users']}"),
                            ],
                          ),
                        ),
                      )
                  );
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },),
    );
  }

  Stream connect() async* {
    print("stat");
    // String ws = ConfigAPIStreamingAdmin.getUserList();
    // print("${ws}");
    // Uri uri = Uri.parse(ws);
    // final channel = WebSocketChannel.connect(uri);
    // Map<String, dynamic> subscription = {
    //   "event": "pusher:subscribe",
    //   "data": {"channel": "user"}};
    // channel.sink.add(jsonEncode(subscription));

    // channel.sink.add(jsonEncode(subscription));

    UserController userController = UserController();
    final test = userController.fetchUserData();

    // channel.stream.listen((event) async {
    //   print("Connection Sucessfully.");
    //   print("cccc: ${event}");
    //   data = jsonDecode(event);
    // }, onError: (error) {
    //   print("${error}");
    // },
    //   onDone: (){
    //     print("Connection done.");
    //
    //   },);
    print("object");

    // setState(() {});
  }
}