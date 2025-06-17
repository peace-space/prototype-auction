import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  State<AddProduct> createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {
  String message = '';

  int indexSelectImage = 0;

  var _dataAuctionTypeValue;
  String? _dataPaymentTypesValue;

  String _inputEndTimeData = '';
  var _inputEndTimeController = TextEditingController();
  String _inputEndDateData = '';
  var _inputEndDateController = TextEditingController();
  var _nameProduct = TextEditingController();
  var _detialProduct = TextEditingController();
  var _shippingCost = TextEditingController();
  var _startPrice = TextEditingController();
  List<File?> _imageData = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มสินค้า')),
      body: StreamBuilder(
        stream: null,
        builder:
            (context, snapshot) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  showOneImage(),
                  showAndSelectImage(),
                  selectShowImage(),
                  SizedBox(height: 8),
                  buttonInputImageProduct(),
                  SizedBox(height: 8),
                  buttonDeleteImageProduct(),
                  Divider(),
                  SizedBox(height: 8),
                  inputDataProduct(),
                  Divider(),
                  SizedBox(height: 8),
                  // inputBankAccount(),
                  // SizedBox(height: 8),
                  buttonSubmit(),

                  SizedBox(height: 500),
                ],
              ),
            ),
      ),
    );
  }

  Widget imagePlatformWebOrAndroid(
      {required List<File?> imageData, required int index}) {
    if (kIsWeb) {
      //return Image.network(imageData[index]!.path, fit: BoxFit.fill,);
      return Image.network(imageData[index]!.path);
    } else if (Platform.isAndroid) {
      // return Image.file(_imageData[index]!, fit: BoxFit.fill);
      return Image.file(_imageData[index]!);
    }

    return Text("Error");
  }

  Widget showOneImage() {
    return Container(
      width: 500,
      height: 300,
        child: (_imageData.length == 0)
            ? Center(child: Text("กรุณาเพิ่มรูปภาพอย่างน้อย 1 ภาพ"),)
            : imagePlatformWebOrAndroid(
            imageData: _imageData, index: indexSelectImage)
      // Image.network(
      //   "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image/car-001.jpg",
      //   fit: BoxFit.fill,
      // ),
    );
  }

  // void imageDataLength() {
  //   if (_imageData.length >)
  // }

  Widget showAndSelectImage() {
    return Container(
      width: 100,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _imageData.length,
        itemBuilder:
            (context, index) => Card(
              child: InkWell(
                  onTap: () =>
                  {
                    setState(() {
                      indexSelectImage = index;
                    })
                  },
                  child: imagePlatformWebOrAndroid(
                      imageData: _imageData, index: index)
              ),
            ),
      ),
    );
  }

  Widget selectShowImage() {
    return Container(
      // color: Colors.lightBlueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () =>
          {
            if (indexSelectImage > 0) {
              setState(() {
                indexSelectImage -= 1;
              })
            }
          }, icon: Icon(Icons.arrow_back_sharp)),
          // Text("Start"),
          Column(
            children: [
              // Text("ทดสอบต่ำแหน่ง: " + indexSelectImage.toString()),
              Text(_imageData.length == 0
                  ? "ไม่มีรูปภาพ"
                  : "รูปภาพที่: ${indexSelectImage + 1} / 10"),
              Text("จำนวนรูปภาพที่เลือกแล้ว: ${_imageData.length} / 10"),
            ],
          ),
          // Text("End"),
          IconButton(
            onPressed: () =>
            {
              if (indexSelectImage < _imageData.length - 1) {
                setState(() {
                  indexSelectImage += 1;
                })
              }
            },
            icon: Icon(Icons.arrow_forward_sharp),
          ),
        ],
      ),
    );
  }

  Widget inputDataProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "เพิ่มข้อมูลสินค้าเพื่อเปิดประมูล",
            style: subjectTextStyle(),
          ),
        ),
        SizedBox(height: 8),
        Text("ประเภทการประมูล", style: subjectTextStyle()),
        inputAuctionTypes(),
        SizedBox(height: 8),
        Text("ชื่อสินค้า:", style: subjectTextStyle()),
        inputNameProduct(),
        SizedBox(height: 8),
        Text("รายละเอียดสินค้า:", style: subjectTextStyle()),
        inputDetailProduct(),
        SizedBox(height: 8),
        Text("ค่าจัดส่ง:", style: subjectTextStyle()),
        inputShippingCost(),
        SizedBox(height: 8),
        Text("ราคาเริ่มต้น", style: subjectTextStyle()),
        inputStartPrice(),
        SizedBox(height: 8),
        Text(
          "เวลาปิดประมูล ( ชั่วโมง : นาที : วินาที )",
          style: subjectTextStyle(),
        ),
        inputEndTime(),
        SizedBox(height: 8),
        Text("วันที่ปิดประมูล ( วัน / เดือน / ปี )", style: subjectTextStyle()),
        inputEndDate(),
        SizedBox(height: 8),

      ],
    );
  }

  Widget buttonInputImageProduct() {
    return ElevatedButton(
        onPressed: () =>
        {
          selectImage()
        },
        child: Text("เลือกรูปภาพ")
    );
  }

  void deleteOneImageProduct() {
    print("ความยาว: " + _imageData.length.toString());
    print("ตำแหน่ง: " + indexSelectImage.toString());
    if (_imageData.length != 0) {
      setState(() {
        _imageData.removeAt(indexSelectImage);
        indexSelectImage -= 1;
      });
    }

    if (indexSelectImage < 0) {
      setState(() {
        indexSelectImage = 0;
      });
    }
  }

  Widget buttonDeleteImageProduct() {
    return ElevatedButton(
        onPressed: () =>
        {
          deleteOneImageProduct()
        },
        child: Text("ลบรูปภาพ")
    );
  }


  Future<void> selectImage() async {
    try {
      int maxImageListLength = 10;

      if (_imageData.length == maxImageListLength) {
        setState(() {
          message = "เพิ่มรูปภาพได้สูงสุด 10 ภาพ";
        });
      } else {
        setState(() {
          message = "";
        });
      }

      // if (kIsWeb) {
      //   print("Web");
      //   // final _piker = await ImagePickerWeb.get
      // }
      //
      // if (Platform.isAndroid) {
      //   print("Android");
      //
      //   if (_imageData.length <= maxImageListLength - 1) {
      //     final _picker = ImagePicker();
      //
      //     final pickedFile = await _picker.pickImage(
      //         source: ImageSource.gallery
      //     );
      //
      //     if (pickedFile != null) {
      //       setState(() {
      //         // imageData = File(pickedFile.path);
      //         _imageData.add(File(pickedFile.path));
      //       });
      //       print("end.aaaaa");
      //     }
      //   }
      // }

      if (_imageData.length <= maxImageListLength - 1) {
        final _picker = ImagePicker();

        final pickedFile = await _picker.pickImage(
            source: ImageSource.gallery
        );

        if (pickedFile != null) {
          setState(() {
            // imageData = File(pickedFile.path);
            _imageData.add(File(pickedFile.path));
          });
          print("end.aaaaa");
        }
      }
    } catch (e) {
      print("ERROR. ${e}");
    }
  }

  Widget inputNameProduct() {
    return TextFormField(
      controller: _nameProduct,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "ชื่อสินค้า",
      ),
    );
  }

  Widget inputDetailProduct() {
    return TextFormField(
      controller: _detialProduct,
      minLines: 1,
      maxLines: 10,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "รายละเอียดสินค้า",
      ),
    );
  }

  Widget inputShippingCost() {
    return TextFormField(
      controller: _shippingCost,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "ค่าจัดส่งสินค้า",
      ),
    );
  }

  Widget inputStartPrice() {
    return TextFormField(
      controller: _startPrice,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "ราคาเปิดประมูล",
      ),
    );
  }

  // Future<DateTime?> inputEndDateTime() {
  Widget inputEndTime() {
    return TextFormField(
      onTap: () => showTimeDialog(),
      controller: _inputEndTimeController,
      // focusNode: FocusNode(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "เวลาปิดประมูล",
      ),
    );
  }

  Future showTimeDialog() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ).then((time_data) {
      if (time_data != null) {
        setState(() {
          int hour = time_data.hour;
          int minute = time_data.minute;

          _inputEndTimeData = '$hour : $minute : 00';
          _inputEndTimeController.text = '$hour : $minute : 00';
        });
      }
    });
  }

  Widget inputEndDate() {
    return TextFormField(
      onTap: () => showDateDialog(),
      controller: _inputEndDateController,
      // focusNode: FocusNode(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "วันที่ปิดประมูล",
      ),
    );
  }

  void showDateDialog() =>
      showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 90)),
        // locale: Locale('th'),
      ).then((date_data) {
        if (date_data != null) {
          setState(() {
            int day = date_data.day;
            int month = date_data.month;
            int year = date_data.year;

            _inputEndDateData = '$year-$month-$day';
            _inputEndDateController.text = '$day / $month / $year';
          });
        }
      });

  // Widget inputAuctionTypes() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         border: OutlineInputBorder(),
  //         hintText: "inputAuctionTypes"
  //     ),
  //   );
  // }

  Widget inputAuctionTypes() {
    List<String>? listDataAuctionTypeValue = ['okay', 'dastards', "2", 'Test'];
    double left = 20,
        top = 0,
        right = 20,
        bottom = 0;
    return DropdownButton(
      hint: Text("เลือกประเภทการประมูล"),
      isExpanded: true,
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      value: _dataAuctionTypeValue,
      items: listDataAuctionTypeValue.map((data) {
        return DropdownMenuItem(value: data, child: Center(child: Text(data),));
      }).toList(),
      onChanged:
          (value) =>
      {
        setState(() {
          _dataAuctionTypeValue = value.toString();
        }),
      },
    );
  }

  // Widget inputBankAccount() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Center(child: Text("เพิ่มข้อมูลการชำระเงิน", style: subjectTextStyle())),
  //       SizedBox(height: 8),
  //       Text("ช่องทางการรับเงิน", style: subjectTextStyle()),
  //       inputPaymentTypes(),
  //       SizedBox(height: 8),
  //       Text("ชื่อบัญชีธนาคาร", style: subjectTextStyle()),
  //       inputNameBankAccount(),
  //       SizedBox(height: 8),
  //       Text("เลขบัญชีธนาคาร", style: subjectTextStyle()),
  //       inputBankAccountNumber(),
  //       SizedBox(height: 8),
  //       Text("พร้อมเพย์", style: subjectTextStyle()),
  //       inputPromptPay(),
  //       SizedBox(height: 8),
  //     ],
  //   );
  // }
  //
  //
  // Widget inputPaymentTypes() {
  //   List<String> testInputPaymentTypes = ['บัญชีธนาคาร', "พร้อมเพย์", "เก็บเงินปลายทาง", "ทั้ง 3 ช่องทาง"];
  //   double left = 20, top = 0, right = 20, bottom = 0;
  //   return DropdownButton<String>(
  //     hint: Text("เลือกประเภทการรับเงิน"),
  //     isExpanded: true,
  //     padding: EdgeInsets.fromLTRB(left, top, right, bottom),
  //     value: _dataPaymentTypesValue,
  //     items:
  //     testInputPaymentTypes.map((data) {
  //       return DropdownMenuItem(value: data, child: Center(child: Text(data),));
  //     }).toList(),
  //     onChanged:
  //         (value) =>
  //     {
  //       setState(() {
  //         _dataPaymentTypesValue = value.toString();
  //       }),
  //     },
  //   );
  // }
  //
  // Widget inputBankAccountNumber() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(),
  //       hintText: "เลขบัญชีธนาคาร",
  //     ),
  //   );
  // }
  //
  // Widget inputNameBankAccount() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(),
  //       hintText: "ชื่อบัญชีธนาคาร",
  //     ),
  //   );
  // }
  //
  // Widget inputPromptPay() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(),
  //       hintText: "พร้อมเพย์",
  //     ),
  //   );
  // }

  Widget buttonSubmit() {
    return ElevatedButton(
        onPressed: () =>
        {
          submit()
        }, child: Text("เปิดประมูล")
    );
  }

  Future<void> submit() async {
    try {
      print("Start Submit");

      String url = 'http://172.24.141.16/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/create-product';
      final uri = Uri.parse(url);
      final request = http.MultipartRequest('POST', uri);

      List<dynamic> stream = [];
      List<dynamic> multiport = [];

      print("Length _imageData: " + _imageData.length.toString());


      if (isSkiaWeb) {
        print("\n\n\n\n" + "Web");
        print(_imageData[0]!.toString());
        print("Web" + "\n\n\n\n\n");
        for (int i = 0; i < _imageData.length; i++) {
          stream.add(_imageData[i]!.readAsBytesSync());
          //
          //   multiport.add(http.MultipartFile.fromBytes(
          //       'image_${i + 1}', stream[i], filename: _imageData[i].toString()));
          //
          //
          //   request.files.add(multiport[i]);
          //   request.fields['image_${i + 1}'] = request.files[i].toString();


          request.files.add(http.MultipartFile(
              "image_${i + 1}", stream[i], _imageData[i]!.lengthSync(),
            // filename: _imageData[i]!.toString(), contentType: {"jpg"}
          ));
        }
      }

      if (Platform.isAndroid) {
        for (int i = 0; i < _imageData.length; i++) {
          stream.add(File(_imageData[i]!.path).readAsBytesSync());

          multiport.add(http.MultipartFile.fromBytes(
              'image_${i + 1}', stream[i], filename: _imageData[i]!.path));

          request.files.add(multiport[i]);
          request.fields['image_${i + 1}'] = request.files[i].toString();
        }
      }

      print("\n\n\n\n" + request.fields.toString() + "\n\n\n\n\n");
      Map<String, dynamic> data = {
        // "data" : "test",
        "id_users": '2',
        // "id_users": ShareData.userData['id_users'].toString(),
        "name_product": "Submit Flutter Test",
        // "name_product": _nameProduct.text,
        "detail_product": "Flutter Detail Test",
        // "detail_product": _detialProduct.text,
        "shipping_cost": "999",
        // "shipping_cost": _shippingCost.text,
        // "start_price": _startPrice.text,
        "start_price": "20",
        "end_date_time": "2025-04-25 01:26:00",
        // "end_date_time": _inputEndDateController.text + " " + _inputEndTimeController.text,
        "id_auction_types": "1",
        "id_payment_types": "1",
        "id_bank_accounts": "1",
      };

      print(data.toString());

      request.fields['id_users'] = data['id_users'];
      request.fields['name_product'] = data['name_product'];
      request.fields['detail_product'] = data['detail_product'];
      request.fields['start_price'] = data['start_price'];
      request.fields['shipping_cost'] = data['shipping_cost'];
      request.fields['end_date_time'] = data['end_date_time'];
      request.fields['id_auction_types'] = data['id_auction_types'];
      request.fields['id_payment_types'] = data['id_payment_types'];
      request.fields['id_bank_accounts'] = data['id_bank_accounts'];

      final response = await request.send();

      if (response.statusCode == 201) {
        print("\n\n\n");
        print("Successfully");
        print("\n\n\n");
      } else {
        print("\n\n\n");
        print("False Status Code: " + response.statusCode.toString());
        print("\n\n\n");
      }
    } on Exception catch (e) {
      print("\n\n\n");
      print("ERROR: " + e.toString());
      print("\n\n\n");
    }
  }

  TextStyle subjectTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18
    );
  }

// Future<void> onSaveProduct() async {
//   try {
//     print("onSaveStart");
//
//     String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/create-product';
//     // String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/test';
//     var uri = Uri.parse(url);
//     var request = http.MultipartRequest('POST', uri);
//
//     // var stream = File(imageData!.path).readAsBytesSync();
//     //
//     // var multiport = http.MultipartFile.fromBytes(
//     //     'image', stream, filename: imageData!.path);
//
//     List<dynamic> stream = [];
//     List<dynamic> multiport = [];
//
//     print(data.length);
//
//     for (int i = 0; i < data.length; i++) {
//       print(i);
//       stream.add(File(data[i]!.path).readAsBytesSync());
//
//       multiport.add(http.MultipartFile.fromBytes(
//           'image_${i + 1}', stream[i], filename: data[i]!.path));
//
//       request.files.add(multiport[i]);
//       request.fields['image_${i + 1}'] = request.files[i].toString();
//     }
//
//     // var image = File(data[0]!.path).readAsBytesSync();
//     // var test = http.MultipartFile.fromBytes('image_1', image, filename: data[0]!.path);
//     // print(test.toString());
//     // request.fields['image_1'] = test;
//
//
//     Map<String, dynamic> body = {
//       'id_users': ShareData.logedIn,
//       'name_product': _nameProduct.text,
//       'detail_product': _detialProduct.text,
//       'start_price': _startPrice.text,
//       'shipping_cost': _shippingCost.text,
//       'start_date_time': _startDate + " " + _startTime,
//       'end_date_time': _endDate + " " + _endTime,
//       'max_price': _maxPrice.text,
//     };
//
//     request.fields['id_users'] = ShareData.userData['id_users'].toString();
//     request.fields['name_product'] = _nameProduct.text;
//     request.fields['detail_product'] = _detialProduct.text;
//     request.fields['start_price'] = _startPrice.text;
//     request.fields['shipping_cost'] = _shippingCost.text;
//     request.fields['start_date_time'] = _startDate + " " + _startTime;
//     request.fields['end_date_time'] = _endDate + " " + _endTime;
//     request.fields['max_price'] = _maxPrice.text.toString();
//
//     // request.fields['id_users'] = '1';
//     // request.fields['name_product'] = 'TestProduct';
//     // request.fields['detail_product'] = "detail";
//     // request.fields['start_price'] = '666';
//     // request.fields['shipping_cost'] = '50';
//     // request.fields['start_date_time'] = '2025-04-24 01:26:00';
//     // request.fields['end_date_time'] = '2025-04-25 01:26:00';
//     // request.fields['max_price'] = '100';
//
//     print(request.fields.toString());
//
//     var response = await request.send();
//
//     if (response.statusCode == 201) {
//       print("Successfull. +++++++++++++++++++++++}");
//     } else {
//       print(
//           "false.------------------------------------${response.statusCode}");
//     }
//
//     print("onSaveEnd");
//   } on Exception catch (e) {
//     print(e);
//   }
// }
}
