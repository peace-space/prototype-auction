class ApiPathLocal {
  late final String api_local_ip = '192.168.1.248';

  late final String login_api_local_post =
      'http://${api_local_ip}/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/login';

  late final String check_login_api_local_get =
      'http://${api_local_ip}/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/check-login';
  late final String register_api_local_post =
      'http://${api_local_ip}/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/register';
  late final String logout_api_local_get =
      'http://${api_local_ip}/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/logout';
  late final String insert_receipt_bill_auction_local_post =
      'http://${api_local_ip}/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/insert-receipt-bill-auction';

  String getLoginApiLocalPost() {
    return this.login_api_local_post;
  }

  String getCheckLoginApiLocalGet() {
    return this.check_login_api_local_get;
  }

  String getRegisterApiLocalPost() {
    return this.register_api_local_post;
  }

  String getLogoutApiLocalGet() {
    return this.logout_api_local_get;
  }

  String getInsertReceiptBillAuctionLocalPost() {
    return insert_receipt_bill_auction_local_post;
  }
}
