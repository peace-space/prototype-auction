class ApiPathServer {
  final String login_api_server_post =
      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/login';
  final String register_api_server_post = '';
  final String logout_api_server_post = '';

  String getLoginApiServer() {
    return this.login_api_server_post;
  }

  String getRegisterApiServer() {
    return this.register_api_server_post;
  }

  String getLogoutServer() {
    return this.logout_api_server_post;
  }
}
