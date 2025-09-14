class ConfigAPIStreamingAdmin {
  // static String url = 'ws://stream.your-auction-services.com/app/gxiziuskahs6vt4k8nle';
  // static String wsUrl = 'wss://stream.your-auction-services.com/app/upkz7upeqdtkia4xh5b8';
  // static String url =
  // 'wss://stream.your-auction-services.com/app/gxiziuskahs6vt4k8nle';
  static String wsUrl = 'ws://192.168.1.248:4010/app/upkz7upeqdtkia4xh5b8';
  // final String url = 'https://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public';

  static String getUserList() {
    String path = '${wsUrl}';
    // String path = '${url}';
    return path;
  }

  static String getAuctionList() {
    return "${wsUrl}";
  }
}
