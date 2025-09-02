import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/user_auction_detail_admin_widget.dart';
import 'package:prototype_your_auction_services/channel/AuctionListAdminChannel.dart';
import 'package:prototype_your_auction_services/model/admin_model/AuctionListAdminModel.dart';
import 'package:prototype_your_auction_services/model/admin_model/ProductDetailModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';
import 'package:prototype_your_auction_services/share/widget_shared/show_count_down_timer.dart';

class UserAuctionListAdminWidget extends StatefulWidget {
  State<UserAuctionListAdminWidget> createState() {
    return UserAuctionListAdminWidgetState();
  }
}

class UserAuctionListAdminWidgetState
    extends State<UserAuctionListAdminWidget> {

  // @override
  // void dispose() {
  //   AuctionListAdminChannel.cloaseAdmin();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายการประมูล")),
      body: StreamBuilder(
        stream: AuctionListAdminChannel
            .connectAdmin()
            .stream,
        builder: (context, snapshot) {
          // print("${snapshot.data}");

          if (snapshot.hasError) {
            return Center(child: Text("เกิดข้อผิดพลาด"));
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text("ไม่มีข้อมูล"));
          }

          if (snapshot.hasData) {
            // print("${snapshot.data}");
            try {
              AuctionListAdminModel auctionListAdminModel = AuctionListAdminModel();
              auctionListAdminModel.setConvertToMapAuctionListAdminData(
                  snapshot.data);
              dynamic data = auctionListAdminModel
                  .getConvertToMapAuctionListAdminData();
              // PrivateAuctionAdminModel().setConvertToMapAuctionListAdminData(snapshot.data);
              // dynamic data = PrivateAuctionAdminModel().getConvertToMapAuctionListAdminData();

              if (data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (data != null) {
                List auction_list_admin_data = data['data'];
                return SafeArea(
                    bottom: true,
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: auction_list_admin_data.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Card(
                              child: ListTile(
                                onTap: () {
                                  goToAuctionDetailAdminWidget(
                                      auction_list_admin_data[index]);
                                },
                                leading: Container(
                                  color: Colors.greenAccent,
                                  child: Image.network(fit: BoxFit.fill,
                                      "${ConfigAPI()
                                          .getImageAuctionApiServerGet(
                                          image_auction_path: auction_list_admin_data[index]['image_path_1'])}"),),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ID Auction: ${auction_list_admin_data[index]['id_auctions']}",
                                      style: textStyle(),),
                                    Text(
                                      "ชื่อสินค้า: ${auction_list_admin_data[index]['name_product']}",
                                      style: textStyle(),),
                                    Text(
                                      "ราคาสูงสุด: ${auction_list_admin_data[index]['max_price']}",
                                      style: textStyle(),),
                                    Text(
                                      "เจ้าของสินค้า: ${auction_list_admin_data[index]['first_name_users']} ${auction_list_admin_data[index]['last_name_users']}",
                                      style: textStyle(),),
                                    // Text("เหลือเวลา: ${auction_list_admin_data[index]['end_date_time']}"),
                                    Text("เหลือเวลา (day:hour:min:sec):",
                                      style: textStyle(),),
                                    countDownList(context,
                                        auction_list_admin_data[index]['end_date_time']),
                                  ],
                                ),
                              ),
                            )
                        );
                      },
                    ));
              }
            } on Exception catch (e) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }

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

  void goToAuctionDetailAdminWidget(Map auction_data) {
    PrivateAuctionAdminModel auctionDetailAdminModel = PrivateAuctionAdminModel();
    auctionDetailAdminModel.setProductDetailData(auction_data);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => UserAuctionDetailAdminWidget(),));
  }

}
