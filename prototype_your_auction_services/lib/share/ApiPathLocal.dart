class ApiPathLocal {
  final String login_api_local_post =
      'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/login';
  final String check_login_api_local_get =
      'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/check-login';
  final String register_api_local_post =
      'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/register';
  final String logout_api_local_get =
      'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/logout';

  String getLoginApiLocalPost() {
    return this.login_api_local_post;
  }

  String getCheckApiLocalGet() {
    return this.check_login_api_local_get;
  }

  String getRegisterApiLocalPost() {
    return this.register_api_local_post;
  }

  String getLogoutApiLocalGet() {
    return this.logout_api_local_get;
  }
}
