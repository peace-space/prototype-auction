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
}
