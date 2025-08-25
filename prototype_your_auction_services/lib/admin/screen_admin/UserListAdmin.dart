import 'dart:convert';

// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/UserDetailAdmin.dart';
import 'package:prototype_your_auction_services/share/ConfigAPIStreamingAdmin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserList extends StatefulWidget {
  State<UserList> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> {
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
    print("object");
    String url = ConfigAPIStreamingAdmin().getUserList();
    print(url.toString());
    Uri uri = Uri.parse(url);
    final channel = WebSocketChannel.connect(uri);
    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "AAA"}
    };
    // final subscription = {"event": "pusher:subscribe", "data": {"channel": "AAA"}};
    channel.sink.add(jsonEncode(subscription));


    // channel.stream.listen((event) async {
    //
    //   print("Connected successfully.");

    //   var dataString = jsonDecode(event);
    //
    //   // print(dataString.toString());
    //   // if (dataString['event'] == 'App\\Events\\AuctionEvent') {
    //   //   var userData = jsonDecode(dataString['data']);
    //   //   print(userData.toString());
    //   //   // data = userData;
    //   //   // _data = userData;
    //   // }
    //
    // },
    //     onDone: () {
    //       print('Connection colose');
    //     },
    //     onError: (error) {
    //       print('${error.toString()}');
    //     });
    return StreamBuilder(
      // stream: UserListAdminModel.fetchStreamingUserData(),
      // stream: null,
      // stream: fetchUserDataTest(),
        stream: channel!.stream,
        // stream: _data.,
      builder:
          (context, snapshot) {
        Map<String, dynamic> events = jsonDecode(snapshot.data);
        var resJson = jsonDecode(events['data']);

        print(resJson.runtimeType.toString());

        if (snapshot.hasError) {
          return Center(
            child: Text('เกิดข้อผิดพลาด'),
          );
        }

        if (resJson['data'] != null) {
          return ListView.builder(
              padding: EdgeInsets.all(20),
              // itemCount: user_data.length,
              itemCount: resJson['data'].length,
              // itemCount: 5,
              itemBuilder: (context, index) {
                final Map data = resJson['data'][index];
                // final id = data['id_users'];
                // final first_name_users = data['first_name_users'];
                // final last_name_users = data['first_name_users'];
                // final phone = data['phone'];
                // return Card(
                //   child: ListTile(
                //     title: Text("${id}) ชื่อ: ${first_name_users
                //         .toString()} ${last_name_users.toString()}"),
                //     subtitle: Text("เบอร์โทร: ${phone.toString()}"),
                //     trailing: editUserData(context, id, data),
                //   ),
                // );

                return Card(
                  child: ListTile(
                    leading: Text(
                        "ชื่อ: ${data['first_name_users']} ${data['last_name_users']}"),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Id Auction: ${data['id_auctions']}'),
                        Text('Auction Status: ${data['auction_status']}'),
                        Text('Shipping cost: ${data['shipping_cost']}'),
                        Text('Start price: ${data['start_price']}'),
                        Text('Max price: ${data['max_price']}'),
                        Text('End Date Time: ${data['end_date_time']}'),
                        Text('Id Product: ${data['id_products']}'),
                        Text('Id Users: ${data['id_users']}'),
                      ],
                    ),
                  ),
                );
              }
              );
        } else {
          // WebSocketChannel.connect(uri);
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Stream fetchUserDataTest() async* {
    print("object");
    String url = ConfigAPIStreamingAdmin().getUserList();
    print(url.toString());
    Uri uri = Uri.parse(url);
    var channel = WebSocketChannel.connect(uri);
    // final subscription = {"event": "pusher:subscribe", "data": {"channel":"AAA"}};
    final subscription = {
      "event": "pusher:subscribe",
      "data": {"channel": "AAA"}
    };
    channel.sink.add(jsonEncode(subscription));
    var data;
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
    // var dataString = jsonDecode(channel.stream.toString());
    // if (dataString['event'] == 'App\\Events\\AuctionEvent') {
    //   var userData = jsonDecode(dataString['data']);
    //   print(userData.toString());
    //   data = userData;
    // }
    // print(_data.toString());
    yield channel.stream;

    // setState(() {});
  }

}
