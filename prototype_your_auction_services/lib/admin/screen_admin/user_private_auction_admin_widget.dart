import 'package:flutter/material.dart';

class UserPrivateAuctionAdminWidget extends StatefulWidget {
  State<UserPrivateAuctionAdminWidget> createState() {
    return UserPrivateAuctionAdminWidgetState();
  }
}

class UserPrivateAuctionAdminWidgetState
    extends State<UserPrivateAuctionAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("การประมูลแบบส่วนตัวของผู้ใช้งาน")),
      body: StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          print("${snapshot.data}");

          if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Text("test");
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
