import 'package:flutter/material.dart';

class UserProduct extends StatefulWidget {
  State<UserProduct> createState() {
    return UserProductState();
  }
}

class UserProductState extends State<UserProduct> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายการสินค้า")),
      body: displayUserProduct(),
    );
  }

  Widget displayUserProduct() {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [DataColumn(label: Center(child: Text("ลำดับ")))],
              rows: [
                DataRow(cells: [DataCell(Text("test"))]),
              ],
            ),
          ),
        );
      },
    );
  }
}
