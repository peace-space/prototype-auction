import 'dart:convert';

class AuctionModel {
  static dynamic auction_select_types_data;

  void setAuctionSelectTypesData({required dynamic auction_select_types_data}){
    try {
      AuctionModel.auction_select_types_data = auction_select_types_data;
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }

  dynamic getAuctionSelectTypesData() {
    try {
      return AuctionModel.auction_select_types_data;
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }


  static late dynamic jsonToMap;

  void setConvertToMapAuctionList(convertToMap) {
    var response = jsonDecode(convertToMap);
    var data;
    if (response['event'] == "App\\Events\\AuctionHomeEvent") {
      data = jsonDecode(response['data']);

      if (data['status'] == 1) {
        AuctionModel.jsonToMap = data['data'];
      } else {
        AuctionModel.jsonToMap = null;
      }
    } else {
      AuctionModel.jsonToMap = null;
    }
  }

  dynamic getConvertToMapAuctionList() {
    return AuctionModel.jsonToMap;
  }
}