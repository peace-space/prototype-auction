import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';
import 'package:prototype_your_auction_services/share/CheckLogin.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

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
    CheckLogin().onCheckLogin();
    setState(() {
      loginStatus = logedIn();
    });
    goToAuctionHome();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("ระบบประมูลออนไลน์",style: TextStyle(
                    fontSize: 18
                ),),
              ],
            ),
          )
    );
  }

  void goToAuctionHome() async {

    await Future.delayed(Duration(seconds:2));

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuctionHome(),));
  }

  String logedIn() {
    if (ShareData.logedIn){
      return "เข้าสู่ระบบแล้ว";
    } else {
      return "ยังไม่เข้าสู่ระบบ";
    }
  }


}

