import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/share/CustomDialog.dart';
import 'package:prototype_your_auction_services/share/confirm_picker.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

class HomeTestSystem extends StatefulWidget {
  State<HomeTestSystem> createState() {
    return HomeTestSystemState();
  }
}

class HomeTestSystemState extends State<HomeTestSystem> {
  bool _confirm = false;
  String _return_value = '';
  var _DropDown;
  bool ignoring = true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomeTest")),
      body: display(),
      drawer: createDrawer(context),
    );
  }

  Widget display() {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(_confirm.toString()),
              button1(context),
              Text("ทดสอบ Confirm Dialog: " + _confirm.toString()),
              button2(context),
              Text("ทดสอบ DropDown: " + _DropDown.toString()),
              dropdownTest(),
              buttonLoadingPage1(),
              buttonLoadingPage2(),
            ],
          ),
        );
      },
    );
  }

  Widget button1(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () => _showCustomDlg(ctx),
      child: Text("ปุ่ม 1"),
    );
  }

  Widget button2(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () => _showConfirmDialog(ctx),
      child: Text("ปุ่ม2: Confirm Dialog"),
    );
  }

  void _showConfirmDialog(BuildContext ctx) async {
    confirmPicker(
      context: context,
      callback: (v) {
        setState(() {
          _confirm = v;
        });
      },
      message: 'ดำเนินการต่อหรือไม่',
    );
  }

  void _showCustomDlg(BuildContext ctx) async {
    String? result = await showDialog(
      context: ctx,
      builder: (_) => CustomDialog(message: "123", title: "Test"),
    );
    setState(() {
      _return_value = result!;
    });
  }

  Widget dropdownTest() {
    //ข้อมูล ต้องเป็น String เท่านั้น
    // ตัวแปร _DropDown ต้องเป็น ชนิดข้อมูล var เท่านั้น
    List<String> dataTestDropDown = ['1', 'BBBB', '3', 'TestDropDown'];
    return DropdownButton<String>(
      value: _DropDown,
      items:
          dataTestDropDown.map((data) {
            return DropdownMenuItem(value: data, child: Text(data));
          }).toList(),
      onChanged:
          (value) => {
            setState(() {
              _DropDown = value.toString();
            }),
          },
    );
  }

  Widget buttonLoadingPage1() {
    return TextButton(
      onPressed: () => {loadingPage1()},
      child: Text("Loading Page"),
    );
  }

  void loadingPage1() async {
    print("\n\n\nLoadingPage\n");

    // IgnorePointer(
    //   child: await showDialog(context: context, builder: (context) => TextButton(onPressed: () => {
    //     print("SAFE+++++++++++++++++++++++++++++++++++++++++++++++")
    //   }, child: Text("SAFE")),),
    // );
    await showDialog(
      context: context,
      builder:
          (context) =>
          AlertDialog(
            title: Text("Test"),
            actions: [
              IgnorePointer(
                ignoring: ignoring,
                child: TextButton(
                  onPressed:
                      () => {print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")},
                  child: Text("ปุ่ม 1"),
                ),
              ),
              TextButton(
                onPressed:
                    () =>
                {
                  print("Ignoring: " + ignoring.toString()),
                  setState(() {
                    if (ignoring == true) {
                      ignoring = false;
                    } else {
                      ignoring = true;
                    }
                  }),
                  print("Ignoring: " + ignoring.toString()),
                },
                child: Text("ปุ่ม 2"),
              ),
            ],
          ),
    );

    // IgnorePointer(
    //   child: await showDialog(
    //     context: context,
    //     builder:
    //         (context) => Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               CircularProgressIndicator(),
    //               Text("กำลังโหนด...", style: TextStyle(
    //                 fontSize: 16,
    //                   color: Colors.blue)),
    //             ],
    //           ),
    //         ),
    //   ),
    // );

    // showDialog(
    //     context: context,
    //     builder: (context) => IgnorePointer(
    //       child: Dialog(
    //           child: TextButton(onPressed: () => {
    //         print("SAFE+++++++++++++++++++++++++++++++++++++++++++++++")
    //       }, child: Text("SAFE"))),
    //     ),
    // );
  }

  Widget buttonLoadingPage2() {
    return TextButton(
      onPressed: () => {loadingPage2()},
      child: Text("Loading Page 2"),
    );
  }

  void loadingPage2() {
    showDialog(
      barrierDismissible: false,
      // useSafeArea: true,
      context: context, builder: (context) =>
        Center(
          child: CircularProgressIndicator(),
        ),);
  }

}
