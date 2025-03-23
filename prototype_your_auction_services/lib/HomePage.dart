import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AppBar.dart';
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';

class HomePage extends StatefulWidget {

  // final Map data;
  // HomePage(this.data);

  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  // final Map data;
  // HomePageState(this.data);

  String loginStatus = "";

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      loginStatus = logedIn();
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        title: Text("HomePage: ${loginStatus}"),
      ),drawer: createDrawer(context),
    );
  }

  String logedIn() {
    if (ShareData.logedIn){
      return "เข้าสู่ระบบแล้ว";
    } else {
      return "ยังไม่เข้าสู่ระบบ";
    }
  }
  
}

