import 'dart:convert';

class PrivateAuctionAdminModel {

  static late dynamic jsonToMap;

  void setConvertToMapAuctionListAdminData(convertToMap) {
    var response = jsonDecode(convertToMap);
    var data;
    if (response['event'] == "App\\Events\\PrivateAuctionListAdminEvent") {
      data = jsonDecode(response['data']);

      if (data['status'] == 1) {
        PrivateAuctionAdminModel.jsonToMap = data;
      } else {
        PrivateAuctionAdminModel.jsonToMap = null;
      }
    } else {
      PrivateAuctionAdminModel.jsonToMap = null;
    }
  }

  dynamic getConvertToMapAuctionListAdminData() {
    return PrivateAuctionAdminModel.jsonToMap;
  }
}