class ConfigAPI {
  // final String url = 'https://rmuti.your-auction-services.com';
  //
  final String url =
      'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public';
  // final String url =
  //     'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1';

  // late final String login_api_server_post = '${url}/api/v1/login';

  late final String check_login_api_server_get = '${url}/api/v1/check-login';

  late final String logout_api_server_get = '${url}/api/v1/logout';

  // late final String image_profile_api_server_get =
  //     '${url}/api/v1/get-image-profile';

  late final String image_api_server_get = '${url}/api/v1/get-imagee';

  // late final String product_detail_server_get = '${url}/api/v1/product-detail';

  late final String bill_auction_api_server_get = '${url}/api/v1/bill-auction';

  late final String insert_receipt_bill_auction_server_post =
      '${url}/api/v1/insert-receipt-bill-auction';

  late final String my_auction_bill_server_get =
      '${url}/api/v1/my-auction-bill';

  late final String confirm_verification_server_post =
      '${url}/api/v1/confirm-verification';

  late final String my_user_profile_server_get = '${url}/api/v1/user';

  late final String edit_my_user_profile_server_post =
      '${url}/api/v1/edit-user-profile';

  late final String create_bank_account_server_post =
      '${url}/api/v1/create-bank-account';

  late final String insert_bank_account_server_post =
      '${url}/api/v1/insert-bank-account';

  // late final String create_product_server_post = '${url}/api/v1/create-product';

  late final String forgot_password_server_post =
      '${url}/api/v1/forgot-password';

  late final String password_reset_server_post = '${url}/api/v1/password-reset';

  late final String user_delete_product_delete =
      '${url}/api/v1/user-product-delete';

  late final String user_bid_delete_server_delete =
      '${url}/api/v1/user-bid-delete';

  late final String chat_server_get = '${url}/api/v1/chat';

  late final String send_message_post = '${url}/api/v1/send-message';

  late final String create_chat_rooms_server_post =
      '${url}/api/v1/create-chat-rooms';

  // late final String private_auction_group_server_get =
  //     '${url}/api/v1/private-auction-group';

  late final String bidder_list_api_server_get = '${url}/api/v1/bidder-list';

  late final String add_bidder_api_server_post = '${url}/api/v1/add-bidder';

  late final String delete_bidder_api_server_post =
      '${url}/api/v1/delete-bidder';

  final String change_password_server_post = '';

  String getLoginApiServerPost() {
    return "${url}/api/v1/login";
  }

  String getCheckLoginApiServerGet() {
    return this.check_login_api_server_get;
  }

  String getRegisterApiServerPost() {
    return '${url}/api/v1/register';
  }

  String getLogoutApiServerGet() {
    return this.logout_api_server_get;
  }

  String getImageProfileApiServerGet({required String image_profile_path}) {
    String path = "${url}/api/v1/get-image-profile" + image_profile_path;
    return path!;
  }

  String getImageAuctionApiServerGet({required var image_auction_path}) {
    String path = "${url}" + image_auction_path.toString();
    return path!;
  }

  String getProductDetailApiServerGet({required var id_auctions}) {
    return "${url}/api/v1/product-detail/${id_auctions.toString()}";
  }

  String getBillAuctionApiServerGet({required id_bill_auction}) {
    String path = this.bill_auction_api_server_get + '/' + id_bill_auction;
    return path!;
  }

  String getInsertReceiptBillAuctionPost() {
    return this.insert_receipt_bill_auction_server_post;
  }

  String getMyAuctionsServerGet({required id_users, required var id_products, required String key_word}) {
    if (key_word.isNotEmpty) {
      print("${id_users}: ${key_word} | ssssssssssssssssssssssssssssssssssssssss");
      return "${url}/api/v1/my-auctions/${id_users.toString()}/${id_products.toString()}/?key_word=${key_word.toString()}";
    } else {
      return "${url}/api/v1/my-auctions/${id_users.toString()}/${id_products.toString()}";
    }
    return "${url}/api/v1/my-auctions/${id_users.toString()}";
  }

  String getMyAuctionBillServerGet({required id_auctions}) {
    String path = this.my_auction_bill_server_get + '/' + id_auctions;
    return path;
  }

  String getConfirmVerificationServerPost() {
    return this.confirm_verification_server_post;
  }

  String getMyUserProfileApiServerGet(String id_users) {
    String path = this.my_user_profile_server_get + '/' + id_users;
    return path;
  }

  String getEditMyUserProfileServerPost() {
    return this.edit_my_user_profile_server_post;
  }

  String getCreateBankAccountServerPost() {
    return this.create_bank_account_server_post;
  }

  String getInsertBankAccountServerPost() {
    return "${url}/api/v1/insert-bank-account";
  }

  String getCreateProducServerPost() {
    // return this.create_product_server_post;
    return "${url}/api/v1/create-product";
  }

  String getForgotPasswordServerPost() {
    return this.forgot_password_server_post;
  }

  String getPasswordResetServerPost() {
    return this.password_reset_server_post;
  }

  String getUserDeleteProductServerDelete({required var id_products}) {
    String path =
        this.user_delete_product_delete + '/' + id_products.toString();
    return path;
  }

  String getUserBidDeleteServerDelete({
    required var id_bids,
    required var id_auctions,
  }) {
    String path =
        this.user_bid_delete_server_delete +
        '/' +
        id_bids.toString() +
        '/' +
        id_auctions.toString();
    return path;
  }

  String getChatRoomsServerGet({required var id_users, required var id_products}) {
    return "${url}/api/v1/chat-rooms/${id_users.toString()}/${id_products.toString()}";
  }

  String getChatServerGet({required var id_chat_rooms}) {
    String path = this.chat_server_get + '/' + id_chat_rooms.toString();
    return path;
  }

  String getSendMessageServerPost() {
    return this.send_message_post;
  }

  String getCreateChatRoomsServerPost() {
    return this.create_chat_rooms_server_post;
  }

  String getPrivateAuctionGroupServerGet({required var id_users}) {
    return "${url}/api/v1/private-auction-group/${id_users}";
  }

  String getBidderListApiServerGet({required var id_auctions}) {
    String path =
        this.bidder_list_api_server_get + '/' + id_auctions.toString();
    return path;
  }

  String getAddBidderApiServerPost() {
    return this.add_bidder_api_server_post;
  }

  String getDeleteBidderApiServerPost() {
    return this.delete_bidder_api_server_post;
  }

  String getUserListAdmin() {
    return "${url}/api/v1/user";
  }

  String getAuctionApi() {
    return "${url}/api/v1/auction";
  }

  String getOneUserApi({required var id_users}) {
    return "${url}/api/v1/user/${id_users.toString()}";
  }

  String getDeleteUserAdminApi({required var id_users}) {
    return "${url}/api/v1/delete-user/${id_users.toString()}";
  }

  String getEditBankAccountAdmin() {
    return "${url}/api/v1/edit-bank-account-admin";
  }

  String getAuctionListAdmin() {
    return "${url}/api/v1/auction-list-admin";
  }

  String getAuctionDetailAdmin({required var id_auctions}) {
    return "${url}/api/v1/auction-detail-admin/${id_auctions.toString()}";
  }

  String getHistoryProduct({required var id_users}) {
    return "${url}/api/v1/history-product/${id_users.toString()}";
  }

  String getResultReportAuction({required var id_users}) {
    return "${url}/api/v1/result-report-auction/${id_users}";
  }

  String getBitList({required var id_auctions}) {
    return "${url}/api/v1/bids/${id_auctions.toString()}";
  }

  String getAdminProductDelete({required var id_products}) {
    return "${url}/api/v1/admin-product-delete/${id_products.toString()}";
  }

  String getPrivateAuctionAdmin() {
    return '${url}/api/v1/private-auction-admin';
  }

  String getBidding() {
    return "${url}/api/v1/bidding";
  }

  String getAddProductTypePost() {
    return "${url}/api/v1/add-product-type";
  }
  String getChangePassWordUserPost() {
    return "${url}/api/v1/change-password-user";
  }

  String getProductTypesGet() {
    return "${url}/api/v1/product-types";
  }

  String getAuctionTypesGet() {
    return "${url}/api/v1/auction-types";
  }

  String getAuctionSelectTypesGet({required var id_products, required String key_word}) {
    // print("api: ${id_products}");
    // id_products = 0;
    if (key_word.isNotEmpty) {
      print("${id_products}: ${key_word} | ssssssssssssssssssssssssssssssssssssssss");
      return "${url}/api/v1/auction-select-product-types/${id_products.toString()}?key_word=${key_word.toString()}";
    } else {
      return "${url}/api/v1/auction-select-product-types/${id_products.toString()}";
    }
    // return "${url}/api/v1/auction-select-product-types/0?key_word=tem";
  }
}
