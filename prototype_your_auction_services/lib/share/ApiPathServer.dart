class ApiPathServer {
  final String login_api_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/login';
  final String check_login_api_server_get =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/check-login';
  final String register_api_server_post =
      'https://your-auction-services.com/prototype-auction/api-pa/api/v1/login';

  final String logout_api_server_get =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/logout';

  final String image_profile_api_server_get =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image-profile';

  final String bill_auction_api_server_get =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/bill-auction';

  final String insert_receipt_bill_auction_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/insert-receipt-bill-auction';

  final String my_auctions_server_get =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/my-auctions';

  final String my_auction_bill_server_get =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/my-auction-bill';

  final String confirm_verification_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/confirm-verification';

  final String my_user_profile_server_get =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/user';

  final String edit_my_user_profile_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/edit-user-profile';

  final String create_bank_account_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/create-bank-account';

  final String insert_bank_account_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/insert-bank-account';

  final String create_product_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/create-product';

  final String forgot_password_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/forgot-password';

  final String password_reset_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/password-reset';

  final String change_password_server_post = '';

  String getLoginApiServerPost() {
    return this.login_api_server_post;
  }

  String getCheckLoginApiServerGet() {
    return this.check_login_api_server_get;
  }

  String getRegisterApiServerPost() {
    return this.register_api_server_post;
  }

  String getLogoutApiServerGet() {
    return this.logout_api_server_get;
  }

  String getImageApiServerGet(String image_profile_path) {
    String path = this.image_profile_api_server_get + image_profile_path;
    print(path);
    return path!;
  }

  String getBillAuctionApiServerGet({required id_bill_auction}) {
    String path = this.bill_auction_api_server_get + '/' + id_bill_auction;
    return path!;
  }

  String getInsertReceiptBillAuctionPost() {
    return this.insert_receipt_bill_auction_server_post;
  }

  String getMyAuctionsServerGet({required id_users}) {
    String path = this.my_auctions_server_get + '/' + id_users;
    return path;
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
    return this.insert_bank_account_server_post;
  }

  String getCreateProducServerPost() {
    return this.create_product_server_post;
  }

  String getForgotPasswordServerPost() {
    return this.forgot_password_server_post;
  }

  String getPasswordResetServerPost() {
    return this.password_reset_server_post;
  }
}
