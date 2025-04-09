import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  State<AddProduct> createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {
  var _startDate = null;
  var _endDate = null;
  var _startTime = null;
  var _endTime = null;
  DateTime now = DateTime.now();
  String message = "";
  File? imageData;
  int locationImage = 0;
  List<File?> data = [];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("เพิ่มสินค้า"),
        ),
        body: StreamBuilder(
          stream: null,
          builder: (context, snapshot) =>
              ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        showImage(),
                        Text("${data.length}/10"),
                        Text("${message}", style: TextStyle(
                            color: Colors.red
                        ),),
                        buttonAddAndDeleteImage(),
                        SizedBox(
                          height: 8,
                        ),
                        textName(),
                        nameProduct(),
                        SizedBox(
                          height: 8,
                        ),
                        textProductDetail(),
                        detialProduct(),
                        SizedBox(
                          height: 8,
                        ),
                        textShippingCost(),
                        shippingCost(),
                        SizedBox(
                          height: 8,
                        ),
                        textStartPrice(),
                        startPrice(),
                        SizedBox(
                          height: 8,
                        ),
                        textStartDate(),
                        textStartTime(),
                        textEndDate(),
                        textEndTime(),
                        SizedBox(
                          height: 8,
                        ),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      )
    );
  }
  Widget showImage() {
    return Container(
      height: 300,
      width: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (data.length == 0) ? 1 : data.length,
        itemBuilder: (context, index) =>
            SizedBox(
                child: GridTile(
                  child: (data.length == 0) ?
                  Image.network(
                    'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public/storage/images/product-images/car-001.jpg',
                    fit: BoxFit.fill, width: 350, height: 300,) :
                  Image.file(data[index]!,
                      fit: BoxFit.fill, width: 350, height: 300),
                )
            ),
      ),
    );
  }

  Widget nameProduct() {
    return TextField(
      onChanged: (value) => {},
      decoration: InputDecoration(
          hintText: "ชื่อสินค้า*"
      ),
    );
  }

  Widget detialProduct() {
    return TextField(
      maxLines: 5,
      controller: TextEditingController(),
      decoration: InputDecoration(
        hintText: "รายละเอียดสินค้า*",
      ),
    );
  }

  Widget test() {
    return TextFormField(

    );
  }

  Widget shippingCost() {
    return TextField(
      decoration: InputDecoration(
          hintText: "ค่าจัดส่งสินค้า*"
      ),
    );
  }

  Widget startPrice() {
    return TextField(
      decoration: InputDecoration(
          hintText: "ราคาเริ่มต้น*"
      ),
    );
  }

  Widget openAuctionButton() {
    return ElevatedButton(
        onPressed: () => {},
        child: Text("เปิดประมูล")
    );
  }

  Future<DateTime?> selectStartDate() {
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
          _startDate = '$day-$month-$year';
        });
      }
    });
  }

  Future<DateTime?> selectEndDate() {
    return showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 90)),
        locale: Locale('en')
    ).then((date) {
      if (date != null) {
        setState(() {
          int day = date.day;
          int month = date.month;
          int year = date.year;
          _endDate = '$day-$month-$year';
        });
      }
    });
  }

  Future<DateTime?> selectStartTime() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ).then((time) {
      if (time != null) {
        setState(() {
          int hour = time.hour;
          int minute = time.minute;
          _startTime = '${hour.toString()}:${minute.toString()}:00';
        });
      }
    });
  }

  Future<TimeOfDay?> selectTimeEnd() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ).then((time) {
      if (time != null) {
        setState(() {
          int hour = time.hour;
          int minute = time.minute;
          _endTime = '$hour:$minute:00';
        });
      }
    });
  }

  Future<void> selectImage() async {
    try {
      int maxImageListLength = 10;

      if (data.length == maxImageListLength) {
        setState(() {
          message = "เพิ่มรูปภาพได้สูงสุด 10 ภาพ";
        });
      } else {
        setState(() {
          message = "";
        });
      }

      if (data.length <= maxImageListLength - 1) {
        final _picker = ImagePicker();

        final pickedFile = await _picker.pickImage(
            source: ImageSource.gallery
        );

        if (pickedFile != null) {
          setState(() {
            imageData = File(pickedFile.path);
            data.add(File(pickedFile.path));
          });
          print("end.aaaaa");
        }
      }
    } catch (e) {
      print("ERROR. ${e}");
    }
  }

  void deleteImage() {
    int maxImageListLength = 10;

    if (data.length > 0) {
      setState(() {
        data.removeAt(data.length - 1);
      });
    }

    if (data.length <= maxImageListLength - 1) {
      setState(() {
        message = "";
      });
    }
  }

  Widget buttonAddAndDeleteImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () =>
            {
              selectImage()
            },
            icon: Icon(Icons.image_outlined)
        ),
        SizedBox(
          width: 100,
        ),
        IconButton(
            onPressed: () =>
            {
              deleteImage()
            },
            icon: Icon(Icons.delete)
        )
      ],
    );
  }

  Widget textName() {
    return Row(
      children: [
        Text(
            "ชื่อสินค้า",
            style: styleText()
        ),
      ],
    );
  }

  Widget textProductDetail() {
    return Row(
      children: [
        Text(
          "รายละเอียดสินค้า",
          style: styleText(),
        ),
      ],
    );
  }

  Widget textShippingCost() {
    return Row(
      children: [
        Text(
            "ราคาจัดส่งสินค้า",
            style: styleText()
        ),
      ],
    );
  }

  Widget textStartDate() {
    return Row(
      children: [
        Text("วันที่เปิดประมูล (วว-ดด-ปปปป): ",
            style: styleText()),
        TextButton(
            onPressed: () => {selectStartDate()},
            child: Text(
              (_startDate != null) ?
              "${_startDate}" :
              "เลือกวันที่", style: styleTextStartDateTime(),)),
      ],
    );
  }

  Widget textEndDate() {
    return Row(
      children: [
        Text("วันที่ปิดประมูล (วว-ดด-ปปปป): ",
            style: styleText()),
        TextButton(
            onPressed: () => {selectEndDate()},
            child: Text(
              (_endDate != null) ?
              "${_endDate}" :
              "เลือกวันที่",
              style: styleTextStartDateTime(),))
      ],
    );
  }

  Widget textStartTime() {
    return Row(
      children: [
        Text("เวลาเปิดประมูล (ชช:นน:วว): ",
          style: styleText(),
        ),
        TextButton(
            onPressed: () =>
            {
              selectStartTime()
            },
            child: Text(
              (_startTime != null) ?
              "${_startTime}" :
              "เลือกเวลา",
              style: styleTextStartDateTime(),)
        )
      ],
    );
  }

  Widget textEndTime() {
    return Row(
      children: [
        Text("เวลาปิดประมูล (ชช:นน:วว): ",
          style: styleText(),),
        TextButton(
            onPressed: () =>
            {
              selectTimeEnd()
            },
            child: Text(
              (_endTime != null) ?
              "${_endTime}" :
              "เลือกเวลา",
              style: styleTextStartDateTime(),)
        )
      ],
    );
  }

  Widget textStartPrice() {
    return Row(
      children: [
        Text(
            "ราคาเปิดประมูล",
            style: styleText()
        ),
      ],
    );
  }

  TextStyle styleTextStartDateTime() {
    return TextStyle(
      fontSize: 18,
      color: Colors.green,
    );
  }

  TextStyle styleTextEndDateTime() {
    return TextStyle(
      fontSize: 18,
      color: Colors.red,
    );
  }

  TextStyle styleText() {
    return TextStyle(
        fontSize: 16,
        color: Colors.lightBlueAccent,
        fontWeight: FontWeight.bold
    );
  }

}