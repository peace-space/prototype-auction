import 'dart:convert';

import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class UserProfileModel {

  static late dynamic user_data;
  static late dynamic bank_account_user;

  void setProductDetailData(dynamic user_profile) {
    var dataJson = jsonDecode(user_profile);
    // print("dataJson: ${dataJson}");
    dynamic userData;
    if (dataJson['event'] == "App\\Events\\UserDetailEvent") {

      userData = jsonDecode(dataJson['data']);

      if (userData['status'] == 1) {
        print('sssssssssssssssssssssssssssssssss${userData['data']}');
        UserProfileModel.user_data = userData['data']['user_data'];
        if (userData['data'] != null) {
          UserProfileModel.bank_account_user = userData['data']['bank_account'];
        } else {
          UserProfileModel.bank_account_user = null;
        }
        // ShareData.bankAccountUser = userData['data']['bank_account'];
        // ShareData.userData = userData['data']['user_data'];
        // ShareData.image_user_profile = userData['data']['image_profile'];
      }
      // userData = userData['data'];
      // user_data = userData['user_data'];
      // bank_account_user = userData['bank_account'];
    }
    // UserProfileModel.user_profile = user_profile;
  }

  dynamic getAuctionDetailUserData() {
    return UserProfileModel.user_data;
  }

  dynamic getAuctionDetailBankAccountUser() {
    return UserProfileModel.bank_account_user;
  }
}