import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/AdminMenu.dart';
import 'package:prototype_your_auction_services/screen/Login.dart';

Drawer createDrawer (BuildContext ctx) {
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
                builder:(ctx)=> Login()
            )
        ),
      },
      child: Text("หน้าหลัก")
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

