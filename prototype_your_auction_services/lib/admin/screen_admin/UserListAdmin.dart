import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/admin/screen_admin/UserDetailAdmin.dart';

class UserList extends StatefulWidget {
  State<UserList> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> {
  List<dynamic> user_data = [];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   userData();
  // }

  Widget build(BuildContext context) {
    // bool _searchMode = false;
    // var _searchCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("รายชื่อผู้ใช้งาน"), actions: [buttSearch()]),
      body: Container(color: Colors.greenAccent, child: streamUserList()),
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

  Stream<dynamic> fetchUserListStream() async* {
    print("Start");
    String url =
        "https://your-auction-services.com/prototype-auction/api-pa/api/user";
    // String url = "https://www.your-auction-services.com/prototype-auction/api-pa/api/user";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    // print(resData.toString());
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      user_data = resData['data'];
    });
    print("End");
  }

  Widget streamUserList() {
    return StreamBuilder(
      stream: fetchUserListStream(),
      builder:
          (context, snapshot) => ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: user_data.length,
            itemBuilder: (context, index) {
              final Map data = user_data[index];
              final id = data['id_users'];
              final name = data['name'];
              final phone = data['phone'];
              return Card(
                child: ListTile(
                  title: Text("${id}) ชื่อ: ${name.toString()}"),
                  subtitle: Text("เบอร์โทร: ${phone.toString()}"),
                  trailing: editUserData(context, id, data),
                ),
              );
            },
          ),
    );
  }
}
