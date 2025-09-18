import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/HomePage.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/AdminMenu.dart';
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';
import 'package:prototype_your_auction_services/screen/AuctionPrivateHome.dart';
import 'package:prototype_your_auction_services/screen/ChatList.dart';
import 'package:prototype_your_auction_services/screen/Login.dart';
import 'package:prototype_your_auction_services/screen/Register.dart';
import 'package:prototype_your_auction_services/screen/ResultReportAuction.dart';
import 'package:prototype_your_auction_services/screen/StoreManage.dart';
import 'package:prototype_your_auction_services/screen/UserProfile.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/Logout.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

import '../screen/HistoryBids.dart';

double iconToTextSpacing() {
  double icon_to_text_spacing = 8.0;
  return icon_to_text_spacing;
}

Drawer createDrawer(BuildContext ctx) {
  // CheckLogin().onCheckLogin();
  if (ShareData.admin && ShareData.logedIn) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            // color: Colors.amber,
            height: 230,
            width: 20,
            child: UserAccountsDrawerHeader(
              currentAccountPicture: showImageProfile(),
              accountName: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Admin", style: TextStyle(
                    color: Colors.yellow
                  ),),
                  Text(
                    "ชื่อ: ${ShareData.userData['first_name_users']} ${ShareData
                        .userData['last_name_users']}",
                  ),
                ],
              ),
              accountEmail: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("data:"),
                  Text("อีเมล: ${ShareData.userData['email']}"),
                  Text("เบอร์โทร: ${ShareData.userData['phone']}"),
                ],
              ),
            ),
          ),
          // testSystem(ctx), // ทดสอบระบบ
          adminMenuButton(ctx),
          homePageButton(ctx),
          buttonGoToAuctionPrivate(ctx),
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
          Container(
            // color: Colors.amber,
            height: 200,
            width: 20,
            child: UserAccountsDrawerHeader(
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
          ),
          // testSystem(ctx), // ทดสอบระบบ
          homePageButton(ctx),
          buttonGoToAuctionPrivate(ctx),
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
          Container(
            height: 200,
            width: 20,
            child: UserAccountsDrawerHeader(
              accountName: Text("ยังไม่ได้เข้าสู่ระบบ"),
              accountEmail: Text("กรุณาเข้าสู่ระบบ"),
            ),
          ),
          // testSystem(ctx), // ทดสอบระบบ
          homePageButton(ctx),
          logedIn(ctx),
          registerStatus(ctx),
        ],
      ),
    );
  }
}

Widget showImageProfile() {
  // if (ShareData.logedIn != false) {
  if (ShareData.image_user_profile != null) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
          '${ConfigAPI().getImageProfileApiServerGet(
              image_profile_path: ShareData.image_user_profile)}'
      ),
    );

  }
  else {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        '${ConfigAPI().getImageProfileApiServerGet(image_profile_path: 'profile-default-image.png')}',
      ),
    );
  }
  // else {
  //   return CircleAvatar(
  //     backgroundImage: NetworkImage(
  //       'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image-profile/storage/images/user-profile-image/profile-default-image.png',
  //     ),
  //   );
  // }
}

Widget HomePageButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.pushReplacement(
          ctx, MaterialPageRoute(builder: (ctx) => HomePage())),
    },
    child: Text("หน้าหลัก"),
  );
}

Widget registerButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.pushReplacement(
          ctx, MaterialPageRoute(builder: (ctx) => Register())),
    },
    child: Row(
      children: [
        Icon(Icons.app_registration),
        SizedBox(width: iconToTextSpacing(),),
        Text("ลงทะเบียน"),
      ],
    ),
  );
}

Widget loginButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      Navigator.pushReplacement(
          ctx, MaterialPageRoute(builder: (ctx) => Login())),
    },
    child: Row(
      children: [
        Icon(Icons.login),
        SizedBox(width: iconToTextSpacing(),),
        Text("เข้าสู่ระบบ"),
      ],
    ),
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
    child: Row(
      children: [
        Icon(Icons.admin_panel_settings),
        SizedBox(width: iconToTextSpacing(),),
        Text("Admin"),
      ],
    ),
  );
}

Widget logOutButton(BuildContext ctx) {
  return ElevatedButton(
    onPressed:
        () =>
    {
      showDialog(context: ctx, builder: (context) => AlertDialog(
        title: Text("ออกจากระบบ"),
        content: Text("คุณต้องการออกจากระบบหรือไม่ ?"),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          } , child: Text("ยกเลิก")),
          TextButton(onPressed: () {
            Logout(context: ctx).onLogout();
          } , child: Text("ตกลง"))
        ],
      ),),
    },
    child: Row(
      children: [
        Icon(Icons.logout),
        SizedBox(width: iconToTextSpacing(),),
        Text("ออกจากระบบ"),
      ],
    ),
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
    child: Row(
      children: [
        Icon(Icons.supervisor_account_rounded),
        SizedBox(width: iconToTextSpacing(),),
        Text("ข้อมูลผู้ใช้งาน"),
      ],
    ),
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
    // child: Icon(Icons.add),
    child: Row(
      children: [
        Icon(Icons.public),
        SizedBox(width: iconToTextSpacing(),),
        Text("หน้าหลัก"),
      ],
    ),
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
    child: Row(
      children: [
        Icon(Icons.chat),
        SizedBox(width: iconToTextSpacing(),),
        Text("แชท"),
      ],
    ),
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
    child: Row(
      children: [
        Icon(Icons.store_mall_directory),
        SizedBox(width: iconToTextSpacing(),),
        Text("จัดการร้านค้า"),
      ],
    ),
  );
}
// ใช้สำหรับทดสอบ
// Widget testSystem(BuildContext ctx) {
//   return ElevatedButton(
//     onPressed:
//         () =>
//     {
//       Navigator.pushReplacement(
//         ctx,
//         MaterialPageRoute(builder: (ctx) => HomeTestSystem()),
//       ),
//     },
//     child: Text("ทดสอบระบบ"),
//   );
// }

Widget buttonGoToHistoryAuction(BuildContext ctx) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (context) => HistoryAuctions()),
      );
    },
    child: Row(
      children: [
        Icon(Icons.history),
        SizedBox(width: iconToTextSpacing(),),
        Text("ประวัติการประมูล"),
      ],
    ),
  );
}

Widget buttonGoToReportAution(BuildContext ctx) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (context) => ReportAuction()),
      );
    },
    child: Row(
      children: [
        Icon(Icons.wallet),
        SizedBox(width: iconToTextSpacing(),),
        Text("รายงานผลการประมูล"),
      ],
    ),
  );
}

Widget buttonGoToAuctionPrivate(BuildContext ctx) {
  return ElevatedButton(onPressed: () {
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (context) => AuctionPrivateHome(),));
  }, child: Row(
    children: [
      Icon(Icons.public_off),
      SizedBox(width: iconToTextSpacing(),),
      Text("ประมูลส่วนตัว"),
    ],
  ));
}