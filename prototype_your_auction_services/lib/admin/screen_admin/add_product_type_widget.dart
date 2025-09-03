import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductTypeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProductTypeWidgetState();
  }

}

class AddProductTypeWidgetState extends State {
  var product_type_ctl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มประเภทสินค้า"),
      ),
      body: ListView(
        children: [
          TextField(
            controller: product_type_ctl,
            decoration: InputDecoration(
              hintText: "เพิ่มประเภทสินค้า"
            ),
          ),
          ElevatedButton(onPressed: (){}, child: Text('เพิ่ม')),
        ],
      ),
    );
  }
}