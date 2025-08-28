import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/UserListAdmin.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';


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
              Text("รายชื่อผู้ใช้งาน"),
              userList(context)
            ],
          )
        ],
      ), drawer: createDrawer(context),
    );
  }

  Widget userList(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(ctx).push(
              MaterialPageRoute(
                  builder: (ctx){
                    return UserListAdmin();
                  },
              )
          );
        },
        child: Text("รายชื่อผู้ใช้งาน")
    );
  }
}