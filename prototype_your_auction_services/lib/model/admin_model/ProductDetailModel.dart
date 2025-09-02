import 'dart:convert';

class PrivateAuctionAdminModel {
  static late dynamic auction_detail_admin;
  static late dynamic jsonToMap;

  void setProductDetailData(Map auction_detail_admin_data) {
    print("AAAA");
    PrivateAuctionAdminModel.auction_detail_admin = auction_detail_admin_data;
  }

  Map getAuctionDetailAdminData() {
    return PrivateAuctionAdminModel.auction_detail_admin;
  }

  void setConvertToMap(convertToMap) {
    print("SSSS");
    var response = jsonDecode(convertToMap);
    print("${response}");
    var data;
    if (response['event'] == "App\\Events\\ProductDetailEvent") {
      data = jsonDecode(response['data']);
    }
    print("${data} 999999999999999999999999999999999999999999999");
    PrivateAuctionAdminModel.jsonToMap = data;
  }

  static dynamic getConvertToMap() {
    return PrivateAuctionAdminModel.jsonToMap;
  }
}
