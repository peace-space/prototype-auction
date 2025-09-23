import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AddProduct.dart';
import 'package:prototype_your_auction_services/screen/CreateBankAccountUser.dart';
import 'package:prototype_your_auction_services/screen/MyAuctions.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

import '../controller/AuctionTypesController.dart';
import '../controller/ProductTypesController.dart';

class StoreManage extends StatefulWidget {
  State<StoreManage> createState() {
    return StoreManageState();
  }
}

class StoreManageState extends State<StoreManage> {
  @override
  void initState() {
    ProductTypesController().fetchProductTypes();
    AuctionTypesController().fetchAuctionTypes();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("จัดการร้านค้า")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          openAuctionsButton(context),
          Divider(),
          buttonGoToUserProduct(context),
          Divider(),
        ],
      ),
      drawer: createDrawer(context),
    );
  }

  Widget openAuctionsButton(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () => goToOpenAuctionButton(ctx),
      child: Text("เปิดประมูล"),
    );
  }

  void goToOpenAuctionButton(BuildContext ctx) {

    var check_bank_account = ShareData.bankAccountUser;

    print("////////////////////////${check_bank_account}");

    if (check_bank_account.isEmpty) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("แจ้งเตือน"),
        content: Text("- กรุณาเพิ่มบัญชีธนาคารก่อนเพิ่มสินค้าเพื่อเปิดประมูล\n"
            "- คุณต้องการเพิ่มบัญชีธนาคารหรือไม่ ?"),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text("ยกเลิก")),
          TextButton(onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBankAccountUser(),));
          } , child: Text("ตกลง"))
        ],
      ),);
    } else {
      final route = MaterialPageRoute(builder: (ctx) => AddProduct());
      Navigator.push(ctx, route);
    }


  }

  Widget buttonGoToUserProduct(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () => goToUserProduct(ctx),
        child: Text("รายการสินค้าของฉัน")
    );
  }

  void goToUserProduct(BuildContext ctx) {
    {
      final route = MaterialPageRoute(builder: (ctx) => MyAuctions());

      Navigator.push(ctx, route);
    }
  }
}
