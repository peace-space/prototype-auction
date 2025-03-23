import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AppBar.dart';
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';

class UserProfile extends StatefulWidget {

  State<UserProfile> createState() {
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลผู้ใช้งาน: ${ShareData.logedIn}"),
      ),
      drawer: createDrawer(context),
    );
  }


}