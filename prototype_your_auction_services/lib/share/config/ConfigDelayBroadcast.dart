class ConfigDelayBroadcast {
  static void onDelay() async {
    await Future.delayed(Duration(seconds: 3));
  }
}