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
}