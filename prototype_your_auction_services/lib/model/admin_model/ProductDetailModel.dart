import 'dart:convert';

class PrivateAuctionAdminModel {
  static late dynamic auction_detail_admin;
  static late dynamic jsonToMap;

  void setProductDetailData(Map auction_detail_admin_data) {
    // print("AAAA");
    PrivateAuctionAdminModel.auction_detail_admin = auction_detail_admin_data;
  }

  Map getAuctionDetailAdminData() {
    return PrivateAuctionAdminModel.auction_detail_admin;
  }

  void setConvertToMap(convertToMap) {
    try {
      var response = jsonDecode(convertToMap);
      // print("${response}");
      var data;
      if (response['event'] == "App\\Events\\ProductDetailEvent") {
        data = jsonDecode(response['data']);
        if (data['status'] == 1) {
          PrivateAuctionAdminModel.jsonToMap = data;
        }
      } else {
        PrivateAuctionAdminModel.jsonToMap = null;
      }
    } on Exception catch (e) {
      PrivateAuctionAdminModel.jsonToMap = null;
      throw Exception(e);
    }
  }

  static dynamic getConvertToMap() {
    try {
      return PrivateAuctionAdminModel.jsonToMap;
    } on Exception catch (e) {
      return null;
      throw Exception(e);
    }
  }
}
