import 'package:prototype_your_auction_services/screen/AppBar.dart';

class UserData {
  static Map<String, dynamic> userData = {};
  final String name;
  final String phone;
  final String address;
  final String email;
  final bool admin;

  UserData({
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.admin,
  });

  Map<String, dynamic> getUserData() {
    Map<String, dynamic> data = {
      'name' : name,
      'phone' : phone,
      'address' : address,
      'email' : email,
      'admin': admin
    };

    return data;
  }
}