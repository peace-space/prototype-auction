import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';

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

  var _nameProduct = TextEditingController();
  var _detialProduct = TextEditingController();
  var _shippingCost = TextEditingController();
  var _startPrice = TextEditingController();

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
                  Container(
                    // color: Colors.green,
                    alignment: Alignment.center,
                    height: 300,
                    width: 350,
                    child: Text("ไม่มีรูปภาพ"),
                  )
                  // Image.network(
                  //   'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public/storage/images/product-images/car-001.jpg',
                  //   fit: BoxFit.fill, width: 350, height: 300,) 
                      :
                  Image.file(data[index]!,
                      fit: BoxFit.fill, width: 350, height: 300),
                )
            ),
      ),
    );
  }

  Widget nameProduct() {
    return TextField(
      controller: _nameProduct,
      decoration: InputDecoration(
          hintText: "ชื่อสินค้า*"
      ),
    );
  }

  Widget detialProduct() {
    return TextField(
      maxLines: 5,
      controller: _detialProduct,
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
      controller: _shippingCost,
      decoration: InputDecoration(
          hintText: "ค่าจัดส่งสินค้า*"
      ),
    );
  }

  Widget startPrice() {
    return TextField(
      controller: _startPrice,
      decoration: InputDecoration(
          hintText: "ราคาเริ่มต้น*"
      ),
    );
  }

  Widget openAuctionButton() {
    return ElevatedButton(
        onPressed: () =>
        {
          onSaveProduct()
        },
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

  // Future<void> selectImage() async {
  //   try {
  //     int maxImageListLength = 10;
  //
  //     if (data.length == maxImageListLength) {
  //       setState(() {
  //         message = "เพิ่มรูปภาพได้สูงสุด 10 ภาพ";
  //       });
  //     } else {
  //       setState(() {
  //         message = "";
  //       });
  //     }
  //
  //     if (data.length <= maxImageListLength - 1) {
  //       final _picker = ImagePicker();
  //
  //       final pickedFile = await _picker.pickImage(
  //           source: ImageSource.gallery
  //       );
  //
  //       if (pickedFile != null) {
  //         setState(() {
  //           imageData = File(pickedFile.path);
  //           data.add(File(pickedFile.path));
  //         });
  //         print("end.aaaaa");
  //       }
  //     }
  //   } catch (e) {
  //     print("ERROR. ${e}");
  //   }
  // }

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

  // void onSaveProduct() async {
  //   print("StartSaveProduct");
  //   print(await http.MultipartFile.fromBytes('images', File(imageData!.path).readAsBytesSync(), filename: imageData!.path));
  //   // Map<String, dynamic> body = {
  //   //   'name_product' : _nameProduct.text,
  //   //   'detail_product' : _detialProduct.text,
  //   //   'start_price' : _startPrice.text,
  //   //   'start_date_time' : _startDate + " " + _startTime,
  //   //   'end_date_time' : _endDate + " " + _endTime,
  //   //   'images' : await http.MultipartFile.fromBytes('images', File(imageData!.path).readAsBytesSync(), filename: imageData!.path)
  //   // };
  //   // print(body.toString());
  //   // String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/create-product';
  //   // final uri = Uri.parse(url);
  //   // final res = await http.post(
  //   //     uri,
  //   //     headers: {"Content-Type": "application/json"},
  //   //     body: jsonEncode(body)
  //   // );
  //
  //   // if (res.statusCode == 201) {
  //   //
  //   // }
  //   print("EndSaveProduct");
  // }

  // Future<void> uploadImage() async {
  // Future<void> onSaveProduct() async {
  //   print("onSaveStart");
  //   var stream = new http.ByteStream(imageData!.openRead());
  //   stream.cast();
  //
  //   var length = await imageData!.length();
  //
  //   String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/create-product';
  //   var uri = Uri.parse(url);
  //   var request = new http.MultipartRequest('POST', uri);
  //
  //   request.fields['title'] = "Static title";
  //
  //   var multiport = new http.MultipartFile('image', stream, length);
  //
  //   request.files.add(multiport);
  //
  //   var response = await request.send();
  //
  //   if (response.statusCode == 201) {
  //     print("Successfull. +++++++++++++++++++++++");
  //   } else {
  //     print("false.------------------------------------");
  //   }
  //
  //   print("onSaveEnd");
  // }

  Future<void> onSaveProduct() async {
    print("onSaveStart");

    // String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/create-product';
    String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/test';
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    // var stream = File(imageData!.path).readAsBytesSync();
    //
    // var multiport = http.MultipartFile.fromBytes(
    //     'image', stream, filename: imageData!.path);

    List<dynamic> stream = [];
    List<dynamic> multiport = [];

    for (int i = 0; i <= 0; i++) {
      stream.add(File(data[i]!.path).readAsBytesSync());

      multiport.add(http.MultipartFile.fromBytes(
          'image', stream[i], filename: data[i]!.path));
      request.files.add(multiport[i]);
    }


    request.fields['id_users'] = ShareData.logedIn.toString();
    request.fields['name_product'] = "NewProduct";

    var response = await request.send();

    if (response.statusCode == 201) {
      print("Successfull. +++++++++++++++++++++++");
    } else {
      print("false.------------------------------------");
    }

    print("onSaveEnd");
  }

}