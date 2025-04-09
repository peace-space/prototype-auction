import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  State<AddProduct> createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {
  var _startDate = TextEditingController();
  DateTime now = DateTime.now();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("เพิ่มสินค้า"),
        ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                showImage(),
                SizedBox(
                  height: 8,
                ),
                nameProduct(),
                detialProduct(),
                shippingCost(),
                startPrice(),
                startDateTime(),
                endDateTime(),
                openAuctionButton(),
                Text(now.hour.toString() + "."
                    + now.minute.toString() + "."
                    + now.second.toString() + ":"
                    + now.day.toString() + "-"
                    + now.month.toString() + "-"
                    + now.year.toString()),
                ElevatedButton(
                  onPressed: () =>
                  {
                    setState(() {
                      now = DateTime.now();
                    })
                  },
                  child: Text("วันเวลาปัจจุบัน"),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
  Widget showImage() {
    return SizedBox(
        height: 200,
        width: 500,
        child: GridTile(
          child: Image.network(
            'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public/storage/images/product-images/car-001.jpg',
            fit: BoxFit.cover,),
          header: GridTileBar(
              title: Row(
              children: [
                InkWell(
                  child: Icon(Icons.add_a_photo_outlined, color: Colors.white,),
                ),
              ],
            ),
              trailing: Row(
                children: [
                  InkWell(
                    child: Icon(Icons.clear_outlined, color: Colors.white,),
                  ),
                ],
              )
          ),
        )
    );
  }

  Widget nameProduct() {
    return TextField(
      onChanged: (value) => {},
      decoration: InputDecoration(
          hintText: "ชื่อสินค้า"
      ),
    );
  }

  Widget detialProduct() {
    return TextField(
      decoration: InputDecoration(
          hintText: "รายละเอียดสินค้า"
      ),
    );
  }

  Widget shippingCost() {
    return TextField(
      decoration: InputDecoration(
          hintText: "ค่าจัดส่งสินค้า"
      ),
    );
  }

  Widget startPrice() {
    return TextField(
      decoration: InputDecoration(
          hintText: "ราคาเริ่มต้น"
      ),
    );
  }

  Widget startDateTime() {
    return TextField(
      controller: _startDate,
      onTap: () =>
      {
        showDateTime(),
      },
      decoration: InputDecoration(
          hintText: "เวลาเปิดประมูล"
      ),
    );
  }

  Widget endDateTime() {
    return Text("เวลาปิดประมูล");
  }

  Widget openAuctionButton() {
    return ElevatedButton(
        onPressed: () => {},
        child: Text("data")
    );
  }

  Future<DateTime?> showDateTime() {
    return showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 90)),
        initialDate: DateTime.now(),
        locale: Locale('en')
    ).then((date) {
      if (date != null) {
        setState(() {
          int day = date.day;
          int month = date.month;
          int year = date.year;
          _startDate.text = '$day-$month-$year';
        });
      }
    });
  }
}