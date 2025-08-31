import 'package:flutter/material.dart';

class UserAuctionListAdminWidget extends StatefulWidget {
  State<UserAuctionListAdminWidget> createState() {
    return UserAuctionListAdminWidgetState();
  }
}

class UserAuctionListAdminWidgetState
    extends State<UserAuctionListAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("เกิดข้อผิดพลาด"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text("ไม่มีข้อมูล"));
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
