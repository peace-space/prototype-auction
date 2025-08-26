import 'dart:convert';

// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/UserDetailAdmin.dart';
import 'package:prototype_your_auction_services/controller/UserController.dart';
import 'package:prototype_your_auction_services/model/admin_model/UserListAdminModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPIStreamingAdmin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserList extends StatefulWidget {
  State<UserList> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> {
  // print("object");
  late String url = ConfigAPIStreamingAdmin().getUserList();

  // print(url.toString());
  late Uri uri = Uri.parse(url);
  late var channel = WebSocketChannel.connect(uri);

  List<dynamic> user_data = [];

  late Stream _data;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    // bool _searchMode = false;
    // var _searchCtrl = TextEditingController();
    // print("object");
    // String url = ConfigAPIStreamingAdmin().getUserList();
    // print(url.toString());
    // Uri uri = Uri.parse(url);
    // final channel = WebSocketChannel.connect(uri);
    // // final subscription = {"event": "pusher:subscribe", "data": {"channel":"AAA"}};
    // final subscription = {"event": "pusher:subscribe", "data": {"channel": "AAA"}};
    // channel.sink.add(jsonEncode(subscription));
    // Stream data;
    // channel.stream.listen((event) async {
    //
    //   print("Connected successfully.");
    //
    //   var dataString = jsonDecode(event);
    //
    //   print(dataString.toString());
    //   if (dataString['event'] == 'App\\Events\\AuctionEvent') {
    //     var userData = jsonDecode(dataString['data']);
    //     print(userData.toString());
    //     data = userData;
    //   }
    //
    // },
    //     onDone: () {
    //       print('Connection colose');
    //     },
    //     onError: (error) {
    //       print('${error.toString()}');
    //     });
    // fetchUserDataTest();
    return Scaffold(
      appBar: AppBar(title: Text("รายชื่อผู้ใช้งาน"), actions: [buttSearch()]),
      body: Container(
          color: Colors.greenAccent,
          child: streamUserList()),
    );
  }

  // Widget userList() {
  //   // userData();
  //   return ListView.builder(
  //     padding: EdgeInsets.all(20),
  //     itemCount: user_data.length,
  //     itemBuilder: (context, index) {
  //       final Map data = user_data[index];
  //       final id = data['id'];
  //       final name = data['name'];
  //       final phone = data['phone'];
  //       return Card(
  //         child: ListTile(
  //           title: Text(name.toString()),
  //           subtitle: Text(phone.toString()),
  //           trailing: editUserData(context, id, data),
  //         )
  //       );
  //     },
  //   );
  // }

  Widget editUserData(BuildContext ctx, id, data) {
    return TextButton(
      onPressed:
          () => {
            Navigator.push(
              ctx,
              MaterialPageRoute(builder: (ctx) => UserManage(id_user: id)),
            ),
          },
      child: Text("จัดการ"),
    );
  }

  Widget searchAppBar() {
    return AppBar(title: Text("Search"));
  }

  Widget buttSearch() {
    return IconButton(onPressed: () => {}, icon: Icon(Icons.search));
  }

  // void userData() async {
  //   print("Start");
  //   String url = "https://www.your-auction-services.com/prototype-auction/api-prototype-auction/api/user";
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   final resData = jsonDecode(response.body);
  //   // print(resData.toString());
  //
  //   setState(() {
  //     user_data = resData['data'];
  //   });
  //
  //   print("End");
  // }

  // Stream<dynamic> fetchUserListStream() async* {
  //   print("Start");
  //   String url =
  //       "https://your-auction-services.com/prototype-auction/api-pa/api/user";
  //   // String url = "https://www.your-auction-services.com/prototype-auction/api-pa/api/user";
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   final resData = jsonDecode(response.body);
  //   // print(resData.toString());
  //   await Future.delayed(const Duration(seconds: 1));
  //   setState(() {
  //     user_data = resData['data'];
  //   });
  //   print("End");
  // }

  Widget streamUserList() {
    // print("object");
    // String url = ConfigAPIStreamingAdmin().getUserList();
    // print(url.toString());
    // Uri uri = Uri.parse(url);
    // final channel = WebSocketChannel.connect(uri);
    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "user"}
    };
    // final subscription = {"event": "pusher:subscribe", "data": {"channel": "AAA"}};
    channel.sink.add(jsonEncode(subscription));
    // channel.closeCode;

    // print(channel.stream);
    // channel.stream.listen((event) async {
    //
    // print("Connected successfully.");
    //
    // var dataString = jsonDecode(event);
    //
    // // print(dataString.toString());
    // if (dataString['event'] == 'App\\Events\\AuctionEvent') {
    //   var userData = jsonDecode(dataString['data']);
    //   // print(userData.toString());
    //   // data = userData;
    //   // _data = userData;
    // }

    // },
    //     onDone: () {
    //       print('Connection colose');
    //     },
    //     onError: (error) {
    //       reConnect();
    //       print('${error.toString()}');
    //     });
    UserController userController = UserController();
    var dataUserController = userController.fetchUserData();
    // UserListAdminModel userListAdminModel = UserListAdminModel(dataUserController);
    // var dd = UserListAdminModel.getData();
    print("SSSSSSSSSS${channel.stream.toString()}");
    return StreamBuilder(
      // stream: UserListAdminModel.fetchStreamingUserData(),
      // stream: null,
      // stream: fetchUserDataTest(),
        stream: channel.stream,
        //     stream: UserListAdminModel.fetchStreamingUserData(),
        builder:
            (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('เกิดข้อผิดพลาด'),
            );
          }

          var aaa = jsonDecode(snapshot.data);
          try {
            if (aaa['event'] == 'pusher:ping') {
              eventPing();
            }
            if (aaa['event'] == 'pusher:pong') {
              eventPong();
            }
          } on Exception catch (e) {
            // print(e.toString());
            // return Center(
            //   child: Text("${snapshot.data}"),
            // );
          }
          // return Text("${snapshot.data}");
          var dataString = jsonDecode(snapshot.data);
          var userData;
          var data;

          if (snapshot.data == null) {
            return Center(
              child: Text('ไม่มีข้อมูล'),
            );
          }

          if (dataString['event'] == 'App\\Events\\UserEvent') {
            userData = jsonDecode(dataString['data']);
            data = userData['data'];
            // print(userData.toString());
          }

          var dataModel;

          if (data != null) {
            // UserListAdminModel userListAdminModel = new UserListAdminModel(data);
            UserListAdminModel userListAdminModel = new UserListAdminModel(
                userData);
            dataModel = UserListAdminModel.getData();
          }
          // return Center(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       ElevatedButton(onPressed: () {
          //         sendTest();
          //       }, child: Text("ส่ง")),
          //       Container(
          //         width: 500,
          //         height: 500,
          //         padding: EdgeInsets.all(8),
          //         child: ListView(
          //           children: [
          //             Text("${data}"),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // );


          // var d = UserListAdminModel.getData();
          // print("dfsfsd"+dataModel['status'].runtimeType.toString());
          //   if (data != null) {
          if (dataModel['status'] == 1) {
            return ListView.builder(
                padding: EdgeInsets.all(20),
                // itemCount: user_data.length,
                itemCount: data.length,
                // itemCount: 5,
                itemBuilder: (context, index) {
                  // UserController userController = UserController();
                  // var test = userController.fetchUserData();
                  // UserListAdminModel userListAdminModel = new UserListAdminModel(data);
                  // var dataModel = UserListAdminModel.getData();
                  return Card(
                    child: ListTile(
                      // leading: Text("${userController.toString()}"),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${data[index]['first_name_users']} ${data[index]['last_name_users']}'),
                          Text('เบอร์โทร: ${data[index]['phone']}'),
                          Text('Data Model: ${data[index]['email']}'),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
          // else {
          //   var aaa = jsonDecode(snapshot.data);
          //   try {
          //     if (aaa['event'] == 'pusher:ping') {
          //       eventPing();
          //     }
          //     if (aaa['event'] == 'pusher:pong') {
          //       eventPong();
          //     }
          //   } on Exception catch (e) {
          //     print(e.toString());
          //     return Center(
          //       child: Text("${snapshot.data}"),
          //     );
          //   }
          //   // reConnect();
          //   return Center(
          //       child: Column(
          //         children: [
          //           ElevatedButton(onPressed: (){
          //             sendTest();
          //           }, child: Text('sendTest')),
          //           ElevatedButton(onPressed: (){
          //             eventPing();
          //           }, child: Text('Ping')),
          //           ElevatedButton(onPressed: (){
          //             eventPong();
          //           }, child: Text('Pong')),
          //           Text("${snapshot.data.toString()}"),
          //           Text("${aaa.runtimeType}"),
          //         ],
          //       ));
          // return Center(
          //   child: Column(
          //     // crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       CircularProgressIndicator(),
          //       Text("กำลังโหลด...")
          //     ],
          //   ),
          // );
          // }
          var a = snapshot.data;
          if (snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('data')),
                  Text("${snapshot.data.toString()}"),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  void reConnect() {
    Future.delayed(const Duration(seconds: 20));
    // channel.sink.close();
    // print("object");
    // String url = ConfigAPIStreamingAdmin().getUserList();
    // print(url.toString());
    // Uri uri = Uri.parse(url);
    // channel = WebSocketChannel.connect(uri);
    // final subscription = {
    //   "event": "pusher:subscribe",
    //   "data": {"channel": "user"}
    // };
    // var subscription = {"event": "pusher:ping"};
    //
    // channel.sink.add(jsonEncode(subscription));

    // subscription = {"event": "pusher:pong"};
    // channel.sink.add(jsonEncode(subscription));
    // UserController userController = new UserController();
    // userController.fetchUserData();
    // setState(() {});
  }

  // Reconnect websocket in 1 seconds
  // onDisconnected() async {
  //   widget.channel.sink.close();
  //   print("Disconnected, trying again in 2s");
  //   new Timer(new Duration(seconds: 2), () async {
  //     await connect();
  //   });

  // connect() async {
  //   try {
  //     IOWebSocketChannel channel = IOWebSocketChannel.connect(HttpService.wsUrl);
  //     Stream stream = channel.stream.asBroadcastStream();
  //     await Future.delayed(Duration(milliseconds: 1000));
  //     await connectionRequest();
  //   } catch (e) {
  //     print("Error! can not connect WS connectWs " + e.toString());
  //     await Future.delayed(Duration(milliseconds: 1000));
  //     IOWebSocketChannel channel = IOWebSocketChannel.connect(HttpService.wsUrl);
  //     Stream stream = channel.stream.asBroadcastStream();
  //     await connectionRequest();
  //   }
  // }

  Stream fetchUserDataTest() async* {
    print("object");
    String url = ConfigAPIStreamingAdmin().getUserList();
    print(url.toString());
    Uri uri = Uri.parse(url);
    var channel = WebSocketChannel.connect(uri);
    // final subscription = {"event": "pusher:subscribe", "data": {"channel":"AAA"}};
    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "user"}
    };
    channel.sink.add(jsonEncode(subscription));
    channel.sink.add(jsonEncode({"test"}));
    // channel.closeCode;
    // yield channel.stream;


    // channel.stream.listen((event) async {
    //
    //   print("Connected successfully.");
    //
    //   var dataString = jsonDecode(event);
    //
    //   print(dataString.toString());
    //   if (dataString['event'] == 'App\\Events\\AuctionEvent') {
    //     var userData = jsonDecode(dataString['data']);
    //     print(userData.toString());
    //     data = userData;
    //     // _data = userData;
    //   }
    //
    // },
    //     onDone: () {
    //       print('Connection colose');
    //     },
    //     onError: (error) {
    //       print('${error.toString()}');
    //     });
    //
    var data;
    var dataString = jsonDecode(channel.stream.toString());
    if (dataString['event'] == 'App\\Events\\AuctionEvent') {
      var userData = jsonDecode(dataString['data']);
      print(userData.toString());
      data = userData;
    }
    print(data.toString());
    yield data;

    // setState(() {});
  }

// void fetchData() async {
//   String url = ConfigAPI().getUserListAdmin();
//   print(url.toString());
//   Uri uri = Uri.parse(url);
//   final response = await http.get(uri);
//   Map<String,dynamic> resData = jsonDecode(response.body);
//   print("CONTROLLER:: ${resData}");
//
// }

  void sendTest() {
    print("object");
    channel.sink.close();
    String url = ConfigAPIStreamingAdmin().getUserList();
    // print(url.toString());
    Uri uri = Uri.parse(url);
    channel = WebSocketChannel.connect(uri);
    // final subscription = {"event": "pusher:subscribe", "data": {"channel":"AAA"}};
    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "user"}
    };
    channel.sink.add(jsonEncode(subscription));
    // channel.sink.add(jsonEncode({"event":"pusher", "channel":"user", "data":{}},));
    // channel.closeCode;
    // yield channel.stream;
    print("============");
    setState(() {

    });


    // channel.stream.listen((event) async {
    //
    //   print("Connected successfully.");
    //
    //   var dataString = jsonDecode(event);
    //
    //   print(dataString.toString());
    //   if (dataString['event'] == 'App\\Events\\AuctionEvent') {
    //     var userData = jsonDecode(dataString['data']);
    //     print(userData.toString());
    //     data = userData;
    //     // _data = userData;
    //   }
    //
    // },
    //     onDone: () {
    //       print('Connection colose');
    //     },
    //     onError: (error) {
    //       print('${error.toString()}');
    //     });
    //
    var data;
    // var dataString = jsonDecode(channel.stream.toString());
    // if (dataString['event'] == 'App\\Events\\AuctionEvent') {
    //   var userData = jsonDecode(dataString['data']);
    //   print(userData.toString());
    //   data = userData;
    // }
    print(data.toString());
  }

  void eventPing() {
    final subscription = {"event": "pusher:ping"};
    // final subscription = {
    //   "event": "pusher:subscribe",
    //   "data": {"channel": "user"}
    // };
    channel.sink.add(jsonEncode(subscription));
    // channel.sink.add(jsonEncode({"event":"pusher", "channel":"user", "data":{}},));
    // channel.closeCode;
    // yield channel.stream;
    // var s = {
    //   "event": "pusher:subscribe",
    //   "data": {"channel": "user"}
    // };
    // channel.sink.add(jsonEncode(s));

    UserController userController = new UserController();
    var data = userController.fetchUserData();
    UserListAdminModel userListAdminModel = new UserListAdminModel(data);
    print("============");
    // setState(() {
    //
    // });
  }

  void eventPong() {
    final subscription = {"event": "pusher:pong"};
    // final subscription = {
    //   "event": "pusher:subscribe",
    //   "data": {"channel": "user"}
    // };
    channel.sink.add(jsonEncode(subscription));
    // channel.sink.add(jsonEncode({"event":"pusher", "channel":"user", "data":{}},));
    // channel.closeCode;
    // yield channel.stream;
    print("============");
    // setState(() {
    //
    // });
  }

}
