import 'dart:convert';

class MyAuctionModel {
  static dynamic my_auction_data;

  void setMyAuctionData({required dynamic my_auction_data}){
    try {
      MyAuctionModel.my_auction_data = my_auction_data;
    } on Exception catch (e) {
      MyAuctionModel.my_auction_data = null;
      Exception("ERROR = ${e}");
    }
  }

  dynamic getAuctionSelectTypesData() {
    try {
      return MyAuctionModel.my_auction_data;
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
      return null;
    }
  }


  static late dynamic jsonToData;

  void setConvertToData(convertToMap) {
    var response = jsonDecode(convertToMap);
    var data;
    if (response['event'] == "App\\Events\\MyAuctionEvent") {
      data = jsonDecode(response['data']);

      print("+++++++++++++++${data}");
      if (data['status'] == 1) {
        if (data['hasData'] != 0) {
          // AuctionModel.jsonToMap = data['data'];
          MyAuctionModel.jsonToData = data['data'];
        } else {
          MyAuctionModel.jsonToData = null;
        }
      } else {
        MyAuctionModel.jsonToData = null;
      }
    } else {
      MyAuctionModel.jsonToData = null;
    }
  }

  dynamic getConvertToData() {
    return MyAuctionModel.jsonToData;
  }
}