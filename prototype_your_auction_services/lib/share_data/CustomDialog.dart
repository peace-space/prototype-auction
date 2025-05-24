import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  int data;
  String? title;

  CustomDialog({required this.data, this.title});

  State<CustomDialog> createState() {
    return CustomDialogState(data: data, title: title);
  }
}

class CustomDialogState extends State<CustomDialog> {
  int data;
  String? title;

  CustomDialogState({required this.data, required this.title});

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("แจ้งเตือน"),
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Text("data"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cencel"),
        ),
        TextButton(onPressed: () => Navigator.pop(context), child: Text("OK")),
      ],
    );
  }
}
