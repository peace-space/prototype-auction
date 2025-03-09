import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/AdminMenu.dart';
import 'package:http/http.dart' as http;

class UserList extends StatefulWidget {
  State<UserList> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> {
  List<dynamic> user_data = [];

  @override
  void initState() {
    // TODO: implement initState
    userData();
    super.initState();

  }

  Widget build(BuildContext context) {
    bool _searchMode = false;
    var _searchCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("รายชื่อผู้ใช้งาน"),
        actions: [
          buttSearch()
        ],
      ),
      body: Container(
        color: Colors.greenAccent,
        child: userList()
      ),
    );
  }



  Widget userList() {
    userData();
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: user_data.length,
      itemBuilder: (context, index) {
        final data = user_data[index];
        final name = data['name'];
        final phone = data['phone'];
        return Card(
          child: ListTile(
            title: Text(name.toString()),
            subtitle: Text(phone.toString()),
            trailing: editUserData(),
          )
        );
      },
    );
  }

  Widget listTitle() {
    return ListTile(
      title: Text("ชื่อ"),
      subtitle: Text("เบอร์โทร"),
      trailing: editUserData(),
    );
  }

  Widget editUserData() {
    return TextButton(
        onPressed: () => {},
        child: Text("จัดการ"),
    );
  }

  Widget searchAppBar() {
    return AppBar(
      title: Text("Search"),
    );
  }

  Widget buttSearch() {
    return IconButton(
        onPressed: () => {},
        icon: Icon(Icons.search),
    );
  }

  void userData() async {
    print("Start");
    String url = "http://127.0.0.1:8000/api/user";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    print(resData.toString());

    setState(() {
      user_data = resData['data'];
    });

    print("End");
  }
}