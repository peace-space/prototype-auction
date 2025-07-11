import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/EditUserProfile.dart';
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';
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
        title: Text("ข้อมูลผู้ใช้งาน"),
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
            Map<String, dynamic> data = snapshot.data!;
            return ListView(
              children: [
                // Text(userData.toString()),
                CircleAvatar(
                  radius: 150,
                  backgroundImage: NetworkImage(
                      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image-profile' +
                          ShareData.userData['image_profile']
                  ),
                ),
                Row(
                  children: [
                    Text("ชื่อ: ", style: textPrefixStyle(),),
                    Text("${snapshot.data?['first_name_users']} ${snapshot
                        .data?['last_name_users']}",
                      style: textStyleUserProfile(),),
                  ],
                ),
                SizedBox(height: height,),
                Row(
                  children: [
                    Text("เบอร์โทร: ", style: textPrefixStyle(),),
                    Text("${snapshot.data?['phone']}",
                      style: textStyleUserProfile(),),
                    SizedBox(height: height,),
                  ],
                ),

                Row(
                  children: [
                    Text("อีเมล: ", style: textPrefixStyle(),),
                    Text("${snapshot.data?['email']}",
                      style: textStyleUserProfile(),),
                    SizedBox(height: height,),
                  ],
                ),

                Text("ที่อยู่ในการรับสินค้า: ", style: textPrefixStyle(),),

                Text("${snapshot.data?['address']}",
                  style: textStyleUserProfile(),),

                Row(
                  children: [
                    Text("ชื่อธนาคาร: ", style: textPrefixStyle(),),
                    Text("${data['name_bank_account']}",
                      style: textStyleUserProfile(),),
                  ],
                ),

                Row(
                  children: [
                    Text("ชื่อบัญชี: ", style: textPrefixStyle(),),
                    Text("ชื่อในบัญชีธนาคาร",
                      style: textStyleUserProfile(),),
                  ],
                ),

                Row(
                  children: [
                    Text("เลขบัญชี: ", style: textPrefixStyle(),),
                    Text("${data['bank_account_number']}",
                      style: textStyleUserProfile(),),
                  ],
                ),

                Row(
                  children: [
                    Text("พร้อมเพย์: ", style: textPrefixStyle(),),
                    Text("${data['prompt_pay']}",
                      style: textStyleUserProfile(),),
                  ],
                ),

                Center(
                  child: Column(
                    children: [
                      SizedBox(height: height,),
                      editProfile(ctx),
                      SizedBox(height: height,),
                      changePassWord(ctx),
                    ],
                  ),
                ),

                SizedBox(
                  height: 200,
                  width: 200,
                ),
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
      fontSize: 16,
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
    String url = ApiPathServer().getMyUserProfileApiServerGet(
        ShareData.userData['id_users'].toString());
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> data = resData['data'];
    ShareData.userData = data;
    yield data;
    setState(() {});
    print("End.");
  }

}