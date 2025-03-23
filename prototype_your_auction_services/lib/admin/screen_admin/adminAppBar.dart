import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/HomePage.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/AdminMenu.dart';

Drawer adminAppbar (BuildContext ctx) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text("Admin"),
          accountEmail: Text("เบอร์โทร"),
        ),
        buttonGeneral(ctx),
        buttonAdminMenu(ctx)
      ],
    ),
  );
}

Widget buttonGeneral(BuildContext ctx){
  return ElevatedButton(
      onPressed: () => {
        Navigator.push(
            ctx,
            MaterialPageRoute(
                builder:(ctx)=> HomePage()
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