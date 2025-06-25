class ApiPathServer {
  final String login_api_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/login';
  final String check_login_api_server_get =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/check-login';
  final String register_api_server_post =
      'https://your-auction-services.com/prototype-auction/api-pa/api/v1/login';

  final String logout_api_server_get =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/logout';

  String getLoginApiServerPost() {
    return this.login_api_server_post;
  }

  String getCheckLoginApiServerGet() {
    return this.check_login_api_server_get;
  }

  String getRegisterApiServerPost() {
    return this.register_api_server_post;
  }

  String getLogoutServerGet() {
    return this.logout_api_server_get;
  }
}
