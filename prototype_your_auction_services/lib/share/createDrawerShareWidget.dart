import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/HomePage.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/AdminMenu.dart';
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';
import 'package:prototype_your_auction_services/screen/ChatList.dart';
import 'package:prototype_your_auction_services/screen/Login.dart';
import 'package:prototype_your_auction_services/screen/Register.dart';
import 'package:prototype_your_auction_services/screen/ResultReportAuction.dart';
import 'package:prototype_your_auction_services/screen/StoreManage.dart';
import 'package:prototype_your_auction_services/screen/UserProfile.dart';
import 'package:prototype_your_auction_services/share/CheckLogin.dart';
import 'package:prototype_your_auction_services/share/Logout.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/test_system/HomeTestSystem.dart';

import '../screen/HistoryBids.dart';

Drawer createDrawer(BuildContext ctx) {
  CheckLogin().onCheckLogin();
  if (ShareData.admin && ShareData.logedIn) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: showImageProfile(),
            accountName: Text(
              "Admin ชื่อ: ${ShareData.userData['first_name_users']} ${ShareData
                  .userData['last_name_users']}",
            ),
            accountEmail: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("อีเมล: ${ShareData.userData['email']}"),
                Text("เบอร์โทร: ${ShareData.userData['phone']}"),
              ],
            ),
          ),
          testSystem(ctx), // ทดสอบระบบ
          adminMenuButton(ctx),
          homePageButton(ctx),
          storaManageButton(ctx),
          userProfile(ctx),
          chatListButton(ctx),
          buttonGoToHistoryAuction(ctx),
          buttonGoToReportAution(ctx),
          logOutButton(ctx),
        ],
      ),
    );
  }

  if (ShareData.logedIn) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: showImageProfile(),
            accountName: Text(
              "ชื่อ: ${ShareData.userData['first_name_users']} ${ShareData
                  .userData['last_name_users']}",
            ),
            accountEmail: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("อีเมล: ${ShareData.userData['email']}"),
                Text("เบอร์โทร: ${ShareData.userData['phone']}"),
              ],
            ),
          ),
          testSystem(ctx), // ทดสอบระบบ
          homePageButton(ctx),
          storaManageButton(ctx),
          userProfile(ctx),
          chatListButton(ctx),
          buttonGoToHistoryAuction(ctx),
          buttonGoToReportAution(ctx),
          logOutButton(ctx),
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

Widget showImageProfile() {
  // if (ShareData.logedIn != false) {
  if (ShareData.userData['image_profile'] != null) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
          'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image-profile' +
              ShareData.userData['image_profile']
      ),
    );

  } else {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image-profile/storage/images/user-profile-image/profile-default-image.png',
      ),
    );
  }
}

Widget HomePageButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => HomePage())),
    },
    child: Text("หน้าหลัก"),
  );
}

Widget registerButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => Register())),
    },
    child: Text("ลงทะเบียน"),
  );
}

Widget loginButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => Login())),
    },
    child: Text("เข้าสู่ระบบ"),
  );
}

Widget adminMenuButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (ctx) => AdminMenu()),
      );
    },
    child: Text("Admin"),
  );
}

Widget logOutButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      ShareData.logedIn = false,
      ShareData.admin = false,
      ShareData.userData = {},
      ShareData.upDateState = () {},
      ShareProductData.productData = {},

      Logout().onLogout(),

      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (ctx) => AuctionHome()),
      ),
    },
    child: Text("ออกจากระบบ"),
  );
}

Widget userProfile(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (ctx) => UserProfile()),
      ),
    },
    child: Text("ข้อมูลผู้ใช้งาน"),
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
    onPressed:
        () =>
    {
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (ctx) => AuctionHome()),
      ),
    },
    child: Text("หน้าหลัก"),
  );
}

Widget chatListButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (ctx) => ChatList()),
      ),
    },
    child: Text("แชท"),
  );
}

Widget storaManageButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (ctx) => StoreManage()),
      ),
    },
    child: Text("จัดการร้านค้า"),
  );
}

Widget testSystem(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (ctx) => HomeTestSystem()),
      ),
    },
    child: Text("ทดสอบระบบ"),
  );
}

Widget buttonGoToHistoryAuction(BuildContext ctx) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        ctx,
        MaterialPageRoute(builder: (context) => HistoryAuctions()),
      );
    },
    child: Text("ประวัติการประมูล"),
  );
}

Widget buttonGoToReportAution(BuildContext ctx) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        ctx,
        MaterialPageRoute(builder: (context) => ReportAuction()),
      );
    },
    child: Text("รายงานผลการประมูล"),
  );
}
