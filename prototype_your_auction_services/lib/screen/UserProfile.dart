import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/EditUserProfile.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

class UserProfile extends StatefulWidget {

  State<UserProfile> createState() {
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> {
  Map<String, dynamic> userData = ShareData.userData;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลผู้ใช้งาน: ${ShareData.logedIn}"),
      ),
      body: Container(
        // color: Colors.lightBlueAccent,
        margin: EdgeInsets.all(20),
        child: userProfile(context),
      ),
      drawer: createDrawer(context),
    );
  }

  Widget userProfile(BuildContext ctx) {
    double height = 3.0;
    return StreamBuilder(
        stream: streamUserData(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("เกิดข้อผิดพลาดในการโหลดข้อมูล",
                style: TextStyle(
                    fontSize: 21
                ),),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ชื่อ: ", style: textPrefixStyle(),),
                Text("${snapshot.data?['name']}",
                  style: textStyleUserProfile(),),
                SizedBox(height: height,),

                Text("เบอร์โทร: ", style: textPrefixStyle(),),
                Text("${snapshot.data?['phone']}",
                  style: textStyleUserProfile(),),
                SizedBox(height: height,),

                Text("อีเมล: ", style: textPrefixStyle(),),
                Text("${snapshot.data?['email']}",
                  style: textStyleUserProfile(),),
                SizedBox(height: height,),

                Text("ที่อยู่ในการรับสินค้า: ", style: textPrefixStyle(),),

                Text("${snapshot.data?['address']}",
                  style: textStyleUserProfile(),),

                Text("บัญชีธนาคาร: ", style: textPrefixStyle(),),
                Text("data",
                  style: textStyleUserProfile(),),

                Text("ชื่อบัญชี: ", style: textPrefixStyle(),),
                Text("data",
                  style: textStyleUserProfile(),),

                Text("เลขบัญชี: ", style: textPrefixStyle(),),
                Text("data",
                  style: textStyleUserProfile(),),

                Text("พร้อมเพย์: ", style: textPrefixStyle(),),
                Text("data",
                  style: textStyleUserProfile(),),

                Center(
                  child: Column(
                    children: [
                      SizedBox(height: height,),
                      editProfile(ctx),
                      SizedBox(height: height,),
                      changePassWord(ctx),
                    ],
                  ),
                )
              ],
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );
  }

  TextStyle textPrefixStyle() {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
    );
  }

  TextStyle textStyleUserProfile() {
    return TextStyle(
      fontSize: 25,
    );
  }

  Widget editProfile(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () => goToEditUserProfile(ctx),
        child: Text("แก้ไขข้อมูลผู้ใช้งาน")
    );
  }

  Widget changePassWord(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () => goToEditUserProfile(ctx),
        child: Text("เปลี่ยนรหัสผ่าน")
    );
  }

  void goToEditUserProfile(BuildContext ctx) {
    final route = MaterialPageRoute(
      builder: (ctx) => EditUserProfile(),
    );
    Navigator.push(ctx, route);
  }

  Stream<Map<String, dynamic>> streamUserData() async* {
    print("Start.");
    String url = 'https://your-auction-services.com/prototype-auction/api-pa/api/user/${ShareData
        .userData['id_users']}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    // print(resData.toString());
    await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> data = resData['data'];
    yield data;
    setState(() {});
    print("End.");
  }

}