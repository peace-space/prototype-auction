import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "ชื่อสินค้า",
      ),
    );
  }

  Widget inputDetailProduct() {
    return TextFormField(
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
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "ค่าจัดส่งสินค้า",
      ),
    );
  }

  Widget inputStartPrice() {
    return TextFormField(
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
    return ElevatedButton(onPressed: () => {}, child: Text("เปิดประมูล"));
  }

  TextStyle subjectTextStyle() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  }
}
