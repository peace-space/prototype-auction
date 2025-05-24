import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/HomePage.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/AdminMenu.dart';
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';
import 'package:prototype_your_auction_services/screen/ChatList.dart';
import 'package:prototype_your_auction_services/screen/Login.dart';
import 'package:prototype_your_auction_services/screen/Register.dart';
import 'package:prototype_your_auction_services/screen/StoreManage.dart';
import 'package:prototype_your_auction_services/screen/UserProfile.dart';
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';
import 'package:prototype_your_auction_services/test_system/HomeTestSystem.dart';

Drawer createDrawer (BuildContext ctx) {
  if (ShareData.admin && ShareData.logedIn) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
                "${ShareData.admin} Admin ชื่อ: ${ShareData.userData['name']}"),
            accountEmail: Text("เบอร์โทรศัพท์: ${ShareData.userData['phone']}"),
          ),
          testSystem(ctx), // ทดสอบระบบ
          adminMenuButton(ctx),
          homePageButton(ctx),
          storaManageButton(ctx),
          userProfile(ctx),
          chatListButton(ctx),
          logOutButton(ctx)
        ],
      ),
    );
  }

  if (ShareData.logedIn) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
                "ชื่อ ${ShareData.userData['name']} ${ShareData.logedIn}"),
            accountEmail: Text("เบอร์โทร: ${ShareData.userData['phone']}"),
          ),
          testSystem(ctx), // ทดสอบระบบ
          homePageButton(ctx),
          storaManageButton(ctx),
          userProfile(ctx),
          chatListButton(ctx),
          logOutButton(ctx)
        ],
      ),
    );
  } else {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("ยังไม่ได้เข้าสู่ระบบ"),
            accountEmail: Text("กรุณาเข้าสู่ระบบ"),
          ),
          testSystem(ctx), // ทดสอบระบบ
          logedIn(ctx),
          registerStatus(ctx),
        ],
      ),
    );
  }
}

Widget HomePageButton(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () => {
        Navigator.push(
          ctx,
            MaterialPageRoute(
                builder: (ctx) => HomePage()
            )
        ),
      },
      child: Text("หน้าหลัก")
  );
}

Widget registerButton(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () => {
        Navigator.push(
            ctx,
            MaterialPageRoute(
                builder:(ctx)=> Register()
            )
        ),
      },
      child: Text("ลงทะเบียน")
  );
}

Widget loginButton(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () => {
        Navigator.push(
            ctx,
            MaterialPageRoute(
                builder:(ctx)=> Login()
            )
        ),
      },
      child: Text("เข้าสู่ระบบ")
  );
}

Widget adminMenuButton(BuildContext ctx) {
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

Widget logOutButton(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () => {
        ShareData.logedIn = false,
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(
            builder: (ctx) => AuctionHome())
        )
      },
      child: Text("ออกจากระบบ")
  );
}

Widget userProfile(BuildContext ctx){
  return ElevatedButton(
      onPressed: () => {
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(
            builder: (ctx) => UserProfile())
        )
      },
      child: Text("ข้อมูลผู้ใช้งาน")
  );
}

Widget logedIn(BuildContext ctx) {
  if (ShareData.logedIn) {
    return logOutButton(ctx);
  } else {
    return loginButton(ctx);
  }
}

Widget registerStatus(BuildContext ctx) {
  if (ShareData.logedIn) {
    return userProfile(ctx);
  } else {
    return registerButton(ctx);
  }
}

Widget homePageButton(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () =>
      {
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(
            builder: (ctx) => AuctionHome())
        )
      },
      child: Text("หน้าหลัก")
  );
}

Widget chatListButton(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () =>
      {
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(
            builder: (ctx) => ChatList())
        )
      },
      child: Text("แชท")
  );
}

Widget storaManageButton(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () =>
      {
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(
            builder: (ctx) => StoreManage())
        )
      },
      child: Text("จัดการร้านค้า")
  );
}

Widget testSystem(BuildContext ctx) {
  return ElevatedButton(
      onPressed: () =>
      {
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(
            builder: (ctx) => HomeTestSystem())
        )
      },
      child: Text("ทดสอบระบบ")
  );
}