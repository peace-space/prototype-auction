import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  String? message;
  String? title;

  CustomDialog({required this.message, this.title});

  State<CustomDialog> createState() {
    return CustomDialogState(message: message, title: title);
  }
}

class CustomDialogState extends State<CustomDialog> {
  var message;
  String? title;

  CustomDialogState({required this.message, required this.title});

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Text(message!),
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
