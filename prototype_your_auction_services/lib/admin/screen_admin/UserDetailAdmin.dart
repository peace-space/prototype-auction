import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/admin/screen_admin/EditUserProfileAdmin.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/UserListAdmin.dart';

class UserManage extends StatefulWidget {
  int id_user;
  UserManage({
    required this.id_user
});
  State<UserManage> createState() {
    return UserManageState(id_user);
  }
}

class UserManageState extends State<UserManage> {
  int id_user;
  Map user_data = {};
  UserManageState(this.id_user);

  @override
  void initState() {
    // TODO: implement initState
    userData();
    super.initState();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("UserID: ${id_user}"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text("รหัสผู้ใช้งาน: ${user_data['id_users']}",
            textScaler: TextScaler.linear(1.5),),
          Text("ชื่อ: ${user_data['first_name_users']}",
              textScaler: TextScaler.linear(1.5)),
          Text("เบอร์โทร: ${user_data['phone']}", textScaler: TextScaler.linear(1.5)),
          Text("อีเมล: ${user_data['email']}", textScaler: TextScaler.linear(1.5)),
          Text("ที่อยู่: ${user_data['address']}", textScaler: TextScaler.linear(1.5)),
          buttonEditUserProfile(context, id_user),
          deleteUserButton(context)
        ],
      ),
    );
  }

  Widget buttonEditUserProfile(BuildContext ctx, int id){
    return ElevatedButton(
            onPressed:  () {
              Navigator.push(
                  ctx, MaterialPageRoute(
                  builder: (ctx) => EditUserProfile(id, user_data)
                )
              );
            },
            child: Text("แก้ไขข้อมูลผู้ใช้งาน")
        );
  }
  Widget userList() {
      // userData();
      return ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: user_data.length,
        itemBuilder: (context, index) {
          final Map data = user_data[index];
          final id = !data['id_users'];
          final name = data['name'];
          final phone = data['phone'];
          return Card(
            child: ListTile(
              title: Text(name.toString()),
              subtitle: Text(phone.toString()),
            )
          );
        },
      );
    }
  void userData() async {
    await Future.delayed(Duration(milliseconds: 300));
    print("aaaa");
    String url = "https://your-auction-services.com/prototype-auction/api-pa/api/user/${id_user}";
    // String url = "https://www.your-auction-services.com/prototype-auction/api-pa/api/user/${id_user}";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    print(resData['data'].toString());
    final data = resData['data'];

    setState(() {
      user_data = data;
    });

    print("bbbb");
  }

  Widget deleteUser() {
    return ElevatedButton(
        onPressed: () => {

        },
        child: Text("ลบผู้ใช้งาน")
    );
  }

  Widget deleteUserButton(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () =>
        {
          onDeleteUser(ctx)
        },
        child: Text("ลบผู้ใช้งาน")
    );
  }

  void onGotoUserList(BuildContext ctx) {
    var route = MaterialPageRoute(
      builder: (ctx) => UserList(),
    );

    Navigator.pushReplacement(ctx, route);
  }

  void onDeleteUser(BuildContext ctx) async {
    String url = "https://your-auction-services.com/prototype-auction/api-pa/api/delete-user/${id_user}";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      print("Successfully.");
      onGotoUserList(ctx);
    } else {
      throw Exception('Failed');
    }
  }


}