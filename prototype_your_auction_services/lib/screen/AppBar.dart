import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/AdminMenu.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/EditUserProfile.dart';
import 'package:prototype_your_auction_services/screen/Login.dart';

Drawer generalAppBar (BuildContext ctx) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
            accountName: Text("ชื่อ นามสกุล"),
            accountEmail: Text("เบอร์โทร"),
        ),
        buttonHomePage(ctx),
        buttonAdminMenu(ctx)
      ],
    ),
  );
}

Widget buttonHomePage(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () => {
        Navigator.push(
          ctx,
            MaterialPageRoute(
                builder:(ctx)=> EditUserProfile(1)
            )
        ),
      },
      child: Text("หน้าแก้ไขข้อมูล")
  );
}

Widget buttonAdminMenu(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(
          builder: (ctx) => AdminMenu())
        );
      },
      child: Text("Admin")
  );
}

