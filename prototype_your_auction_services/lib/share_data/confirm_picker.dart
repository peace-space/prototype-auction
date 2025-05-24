import 'package:flutter/material.dart';

void confirmPicker({
  required BuildContext context,
  required Function callback,
  String message = '',
  String data = '',
}) async {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("$message", style: TextStyle(fontSize: 16)),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text("$data", style: TextStyle(fontSize: 16)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                callback(false);
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 18)),
            ),
            TextButton(
              onPressed: () {
                callback(true);
                Navigator.of(context).pop();
              },
              child: Text("OK", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
  );
}
