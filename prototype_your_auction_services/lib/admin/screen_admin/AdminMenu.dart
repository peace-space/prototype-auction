import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/UserListAdmin.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/user_auction_list_admin_widget.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/user_private_auction_admin_widget.dart';
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
              userList(context),
              goToAuctionListAdmin(),
              goToPrivateAuctionAdmin(),
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

  Widget goToAuctionListAdmin() {
    return ElevatedButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => UserAuctionListAdminWidget(),));
    }, child: Text("รายการประมูลแบบปกติ"));
  }
  
  Widget goToPrivateAuctionAdmin() {
    return ElevatedButton(onPressed: () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserPrivateAuctionAdminWidget(),));
    }, child: Text("รายการประมูลแบบส่วนตัว"));
  }
}