import 'dart:convert';

import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class UserProfileModel {

  static late dynamic user_data;
  static late dynamic bank_account_user;

  void setProductDetailData(dynamic user_profile) {
    try {
      var dataJson = jsonDecode(user_profile);
      dynamic userData;

      if (dataJson['event'] == "App\\Events\\UserDetailEvent") {

        userData = jsonDecode(dataJson['data']);

        if (userData['status'] == 1) {

          if (userData['data']['user_data'] != null) {

            UserProfileModel.user_data = userData['data']['user_data'];

            if (userData['data'] != null) {

              UserProfileModel.bank_account_user = userData['data']['bank_account'];

            } else {
              UserProfileModel.bank_account_user = null;
            }
          }
          // ShareData.bankAccountUser = userData['data']['bank_account'];
          // ShareData.userData = userData['data']['user_data'];
          // ShareData.image_user_profile = userData['data']['image_profile'];
        } else {
          UserProfileModel.user_data == null;
          UserProfileModel.bank_account_user == null;
        }

      } else {
        UserProfileModel.user_data = null;
        UserProfileModel.bank_account_user = null;
      }
    } on Exception catch (e) {
      UserProfileModel.user_data = null;
      UserProfileModel.bank_account_user = null;
    }

  }

  dynamic getAuctionDetailUserData() {
    return UserProfileModel.user_data;
  }

  dynamic getAuctionDetailBankAccountUser() {
    return UserProfileModel.bank_account_user;
  }
}