class AuctionTypesModel {
  static dynamic auction_types_data;

  void setAuctionTypes({required dynamic auction_types}) {
    try {
      AuctionTypesModel.auction_types_data = auction_types;
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }


  dynamic getAuctionTypes() {
    try {
      return AuctionTypesModel.auction_types_data;
    } on Exception catch (e) {
      Exception("ERROR = ${e}");
    }
  }
}