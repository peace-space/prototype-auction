import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/UserList.dart';
import 'package:prototype_your_auction_services/screen/AppBar.dart';

class AdminMenu extends StatefulWidget {
  State<AdminMenu> createState() {
    return AdminMenuState();
  }
}

class AdminMenuState extends State<AdminMenu> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              userList(context)
            ],
          )
        ],
      ),
    );
  }

  Widget userList(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(ctx).push(
              MaterialPageRoute(
                  builder: (ctx){
                    return UserList();
                  },
              )
          );
        },
        child: Text("รายชื่อผู้ใช้งาน")
    );
  }
}