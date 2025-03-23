import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AppBar.dart';
import 'package:prototype_your_auction_services/screen/EditUserProfile.dart';
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';

class UserProfile extends StatefulWidget {

  State<UserProfile> createState() {
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> {
  Map<String, dynamic> userData = ShareData.userData;

  @override
  void initState() {
    // TODO: implement initState
    streamUserData();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลผู้ใช้งาน: ${ShareData.logedIn}"),
      ),
      body: Container(
        color: Colors.lightBlueAccent,
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
        builder: (context, snapshot) {
          return Column(
            children: [
              Row(
                children: [
                  Text("ชื่อ: ", style: textPrefixStyle(),),
                  Text("${snapshot.data?['name']}",
                    style: textStyleUserProfile(),),
                ],
              ),
              SizedBox(height: height,),
              Row(
                children: [
                  Text("เบอร์โทร: ", style: textPrefixStyle(),),
                  Text("${ShareData.userData['phone']}",
                    style: textStyleUserProfile(),),
                ],
              ),
              SizedBox(height: height,),
              Row(
                children: [
                  Text("อีเมล: ", style: textPrefixStyle(),),
                  Text("${ShareData.userData['email']}",
                    style: textStyleUserProfile(),),
                ],
              ),
              SizedBox(height: height,),
              Row(
                children: [
                  Text("ที่อยู่ในรับสินค้า: ", style: textPrefixStyle(),),
                ],
              ),
              Row(
                children: [
                  Text("${ShareData.userData['address']}",
                    style: textStyleUserProfile(),),
                ],
              ),
              SizedBox(height: height,),
              editProfile(ctx),
              SizedBox(height: height,),
              changePassWord(ctx),
            ],
          );
        }
    );
  }

  TextStyle textPrefixStyle() {
    return TextStyle(
        fontSize: 18,
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
    await Future.delayed(Duration(seconds: 1));
    yield ShareData.userData;
    setState(() {
      streamUserData();
    });
    print("End.");
  }

}