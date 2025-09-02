import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/user_private_auction_detail_admin_widget.dart';
import 'package:prototype_your_auction_services/channel/UserPrivateAuctionListAdminChannel.dart';
import 'package:prototype_your_auction_services/model/admin_model/PrivateAuctionAdminModel.dart';
import 'package:prototype_your_auction_services/model/admin_model/PrivateProductDetailModel.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

import '../../share/ConfigAPI.dart';
import '../../share/widget_shared/show_count_down_timer.dart';

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
      appBar: AppBar(title: Text("การประมูลแบบส่วนตัว")),
      body: StreamBuilder(
        stream: UserPrivateAuctionAdminChannel.connect().stream,
        builder: (context, snapshot) {
          print("${snapshot.data}");

          if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.none) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            PrivateAuctionAdminModel().setConvertToMapAuctionListAdminData(snapshot.data);
            dynamic data = PrivateAuctionAdminModel().getConvertToMapAuctionListAdminData();

            if (data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (data != null) {
              List private_auction_data = data['data'];
              return SafeArea(
                  bottom: true,
                  child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: private_auction_data.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                goToPrivateAuctionDetailAdminWidget(
                                    private_auction_data[index]);
                              },
                              leading: Container(
                                color: Colors.greenAccent,
                                child: Image.network(fit: BoxFit.fill,
                                    "${ConfigAPI()
                                        .getImageAuctionApiServerGet(
                                        image_auction_path: private_auction_data[index]['image_path_1'])}"),),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ID Auction: ${private_auction_data[index]['id_auctions']}",
                                    style: textStyle(),),
                                  Text(
                                    "ชื่อสินค้า: ${private_auction_data[index]['name_product']}",
                                    style: textStyle(),),
                                  Text(
                                    "ราคาสูงสุด: ${private_auction_data[index]['max_price']}",
                                    style: textStyle(),),
                                  Text(
                                    "เจ้าของสินค้า: ${private_auction_data[index]['first_name_users']} ${private_auction_data[index]['last_name_users']}",
                                    style: textStyle(),),
                                  // Text("เหลือเวลา: ${auction_list_admin_data[index]['end_date_time']}"),
                                  Text("เหลือเวลา (day:hour:min:sec):",
                                    style: textStyle(),),
                                  countDownList(context,
                                      private_auction_data[index]['end_date_time']),
                                ],
                              ),
                            ),
                          )
                      );
                    },
                  )
              );

            }}
          return Center(child: CircularProgressIndicator());
        },
      ), drawer: createDrawer(context),
    );

  }
  TextStyle textStyle() {
    return TextStyle(
        fontSize: 13
    );
  }

  void goToPrivateAuctionDetailAdminWidget(Map private_auction_detail_admin_data) {
    // PrivateAuctionAdminModel auctionDetailAdminModel = PrivateAuctionAdminModel();
    // auctionDetailAdminModel.setProductDetailData(auction_data);

    PrivateProductDetailModel privateProductDetailModel = PrivateProductDetailModel();
    privateProductDetailModel.setProductDetailData(private_auction_detail_admin_data);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => PrivateAuctionDetailAdminWidget(),));
  }
}
