import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/admin/screen_admin/EditUserProfile.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/UserList.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/adminAppBar.dart';

class UserManage extends StatefulWidget {
  int id_user;
  Map user_data;
  UserManage({
    required this.id_user, required this.user_data
});
  State<UserManage> createState() {
    return UserManageState(id_user, user_data);
  }
}

class UserManageState extends State<UserManage> {
  int id_user;
  Map user_data;
  UserManageState(this.id_user, this.user_data);

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("UserID: ${id_user}"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Text("รหัสผู้ใช้งาน: ${user_data['id']}", textScaler: TextScaler.linear(1.5),),
          Text("ชื่อ: ${user_data['name']}", textScaler: TextScaler.linear(1.5)),
          Text("เบอร์โทร: ${user_data['phone']}", textScaler: TextScaler.linear(1.5)),
          Text("อีเมล: ${user_data['email']}", textScaler: TextScaler.linear(1.5)),
          Text("ที่อยู่: {user_data['address']}", textScaler: TextScaler.linear(1.5)),
          buttonEditUserProfile(context, id_user),
        ],
      ),drawer: adminAppbar(context),
    );
  }

  Widget buttonEditUserProfile(BuildContext ctx, int id){
    return ElevatedButton(
            onPressed:  () {
              Navigator.pushReplacement(
                  ctx, MaterialPageRoute(
                  builder: (ctx) => EditUserProfile(id)
                )
              );
            },
            child: Text("แก้ไขข้อมูลผู้ใช้งาน")
        );
  }

}