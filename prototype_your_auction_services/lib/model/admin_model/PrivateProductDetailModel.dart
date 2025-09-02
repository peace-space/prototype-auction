class PrivateProductDetailModel {
  static late dynamic private_auction_detail_admin;

  void setProductDetailData(Map private_auction_detail_admin_data) {
    print("AAAA");
    PrivateProductDetailModel.private_auction_detail_admin = private_auction_detail_admin_data;
  }

  Map getAuctionDetailAdminData() {
    return PrivateProductDetailModel.private_auction_detail_admin;
  }
}