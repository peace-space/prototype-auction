import 'dart:convert';

class AuctionListAdminModel {
  static dynamic auction_list_admin_data;
  static late dynamic jsonToMap;

  static setAuctionListAdminData(auction_list_data) {
    AuctionListAdminModel.auction_list_admin_data = auction_list_data;
  }

  static getAuctionListAdminData() {
    return AuctionListAdminModel.auction_list_admin_data;
  }

  void setConvertToMapAuctionListAdminData(convertToMap) {
    // print("SSSS");
    var response = jsonDecode(convertToMap);
    // print("${response}");
    var data;
    if (response['event'] == "App\\Events\\AuctionListAdminEvent") {
      data = jsonDecode(response['data']);

      AuctionListAdminModel.jsonToMap = data;
    }
    // print("${data}999999999999999999999999999999999999999999999");
  }

  dynamic getConvertToMapAuctionListAdminData() {
    return AuctionListAdminModel.jsonToMap;
  }
}
