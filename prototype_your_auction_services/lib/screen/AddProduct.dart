import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:prototype_your_auction_services/controller/AuctionTypesController.dart';
import 'package:prototype_your_auction_services/controller/ProductTypesController.dart';
import 'package:prototype_your_auction_services/model/AuctionTypesModel.dart';
import 'package:prototype_your_auction_services/model/ProductTypesModel.dart';
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

import '../share/ShareUserData.dart';

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
  var _productTypeValues;

  String _inputEndTimeData = '';
  var _inputEndTimeController = TextEditingController();
  String _inputEndDateData = '';
  var _inputEndDateController = TextEditingController();
  var _nameProduct = TextEditingController();
  var _detialProduct = TextEditingController();
  var _shippingCost = TextEditingController();
  var _startPrice = TextEditingController();

  // List<File?> _imageData = [];
  List<dynamic?> _imageData = [];

  @override
  void initState() {
    ProductTypesController().fetchProductTypes();
    AuctionTypesController().fetchAuctionTypes();
    super.initState();
  }

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
                  Text(
                    message,
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),

                  buttonSubmit(),

                  SizedBox(height: 500),
                ],
              ),
            ),
      ),
    );
  }

  Widget imagePlatformWebOrAndroid({
    required List<dynamic?> imageData,
    required int index,
  }) {
    if (kIsWeb) {
      //return Image.network(imageData[index]!.path, fit: BoxFit.fill,);
      return Image.network(imageData[index]!.path.toString());
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
      child:
          (_imageData.length == 0)
              ? Center(child: Text("กรุณาเพิ่มรูปภาพอย่างน้อย 1 ภาพ"))
              : imagePlatformWebOrAndroid(
                imageData: _imageData,
                index: indexSelectImage,
              ),
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
                onTap:
                    () => {
                      setState(() {
                        indexSelectImage = index;
                      }),
                    },
                child: imagePlatformWebOrAndroid(
                  imageData: _imageData,
                  index: index,
                ),
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
          IconButton(
            onPressed:
                () => {
                  if (indexSelectImage > 0)
                    {
                      setState(() {
                        indexSelectImage -= 1;
                      }),
                    },
                },
            icon: Icon(Icons.arrow_back_sharp),
          ),
          // Text("Start"),
          Column(
            children: [
              // Text("ทดสอบต่ำแหน่ง: " + indexSelectImage.toString()),
              Text(
                _imageData.length == 0
                    ? "ไม่มีรูปภาพ"
                    : "รูปภาพที่: ${indexSelectImage + 1} / 10",
              ),
              Text("จำนวนรูปภาพที่เลือกแล้ว: ${_imageData.length} / 10"),
            ],
          ),
          // Text("End"),
          IconButton(
            onPressed:
                () => {
                  if (indexSelectImage < _imageData.length - 1)
                    {
                      setState(() {
                        indexSelectImage += 1;
                      }),
                    },
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
        Text("ประเภทสินค้า", style: subjectTextStyle()),
        inputProductTypes(),
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
        Text(
          "วันที่ปิดประมูล ( วัน / เดือน / ปี ค.ศ.)",
          style: subjectTextStyle(),
        ), inputEndDate(),
        SizedBox(height: 8),
      ],
    );
  }

  Widget buttonInputImageProduct() {
    return ElevatedButton(
      onPressed: () => {selectImage()},
      child: Text("เลือกรูปภาพ"),
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
      onPressed: () => {deleteOneImageProduct()},
      child: Text("ลบรูปภาพ"),
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

      // FilePickerResult? result = await FilePicker.platform.pickFiles();
      //
      // if (result != null) {
      //   PlatformFile file = result.files.first;
      //
      //   print(file.name);
      //   print(file.bytes);
      //   print(file.size);
      //   print(file.extension);
      //   print(file.path);
      // } else {
      //   // User canceled the picker
      // }

      if (_imageData.length <= maxImageListLength - 1) {
        if (kIsWeb) {
          print("\nWeb +++++++++++++++++++++ ");
          FilePickerResult? selectImage = await FilePicker.platform.pickFiles();
          if (selectImage != null) {
            PlatformFile? fileImage = selectImage.files.first;

            setState(() {
              _imageData.add(fileImage);
            });
          }
        } else if (Platform.isAndroid) {
          print("Android");

          if (_imageData.length <= maxImageListLength - 1) {
            final _picker = ImagePicker();

            final pickedFile = await _picker.pickImage(
              source: ImageSource.gallery,
            );

            if (pickedFile != null) {
              setState(() {
                _imageData.add(File(pickedFile.path));
              });
              print("end.aaaaa");
            }
          }
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
      keyboardType: TextInputType.number,
      controller: _shippingCost,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "ค่าจัดส่งสินค้า",
      ),
    );
  }

  Widget inputStartPrice() {
    return TextFormField(
      keyboardType: TextInputType.number,
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
      readOnly: true,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "เวลาปิดประมูล",
      ),
    );
  }

  Future showTimeDialog() {
    return showTimePicker(context: context, initialTime: TimeOfDay.now()).then((
      time_data,
    ) {
      if (time_data != null) {
        setState(() {
          int hour = time_data.hour;
          int minute = time_data.minute;

          _inputEndTimeData = '$hour:$minute:00';
          _inputEndTimeController.text = '$hour : $minute : 00';
        });
      }
    });
  }

  Widget inputEndDate() {
    return TextFormField(
      readOnly: true,
      onTap: () => showDateDialog(),
      controller: _inputEndDateController,
      keyboardType: TextInputType.datetime,
      // focusNode: FocusNode(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "วันที่ปิดประมูล",
      ),
    );
  }

  void showDateDialog() => showDatePicker(
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
    dynamic auction_types_data = AuctionTypesModel().getAuctionTypes();

    Future.delayed(Duration(milliseconds: 300));

    List<String>? listDataAuctionTypeValue = [];
    for (int i = 0; i <= auction_types_data.length - 1; i++) {
      // print('${i} ${auction_types_data[i]['auction_types']}');
      listDataAuctionTypeValue.add(auction_types_data[i]['auction_types'].toString());
    }
    // List<String>? listDataAuctionTypeValue = [
    //   'ประมูลปกติ',
    //   'ประมูลแบบส่วนตัว',
    // ];
    double left = 20, top = 0, right = 20, bottom = 0;
    return DropdownButton(
      hint: Text("เลือกประเภทการประมูล"),
      isExpanded: true,
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      value: _dataAuctionTypeValue,
      items:
          listDataAuctionTypeValue.map((data) {
            return DropdownMenuItem(
              value: data,
              child: Center(child: Text(data)),
            );
          }).toList(),
      onChanged:
          (value) => {
            setState(() {
              _dataAuctionTypeValue = value.toString();
            }),
          },
    );
  }

  Widget inputProductTypes() {
    dynamic test = ProductTypesModel().getProductTypes();

    Future.delayed(Duration(milliseconds: 300));

    // List<String>? product_types = [
    //   'ทั่วไป',
    //   'ของเก่า',
    //   'เสื้อผ้า',
    //   'ของใช้',
    //   'เทคโนโลยี',
    //   'เครื่องดนตรี',
    //   'นาฬิกา',
    //   'เครื่องประดับ',
    //   'จักรยานยนต์',
    //   'รถยนต์',
    // ];

    List<String>? product_types = [];
    for (int i = 0; i <= test.length - 1; i++) {
      // print('${i} ${test[i]['product_type_text']}');
      product_types.add(test[i]['product_type_text'].toString());
    }
    // product_types.add('อื่น ๆ');
    // print("${test} ${product_types.length}");
    double left = 20,
        top = 0,
        right = 20,
        bottom = 0;
    return DropdownButton(
      hint: Text("ประเภทสินค้า"),
      isExpanded: true,
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      value: _productTypeValues,
      items:
      product_types.map((data) {
        return DropdownMenuItem(
          value: data,
          child: Center(child: Text(data)),
        );
      }).toList(),
      onChanged:
          (value) =>
      {
        setState(() {
          _productTypeValues = value.toString();
        }),
      },
    );
  }

  Widget buttonSubmit() {
    return ElevatedButton(
      onPressed: () => {submit()},
      child: Text("เปิดประมูล"),
    );
  }

  void submit() async {
    try {
      print("Start Submit");

      var check_integer_shipping_cost;
      var check_integer_start_price;

      try {
        print("Test");
        check_integer_shipping_cost = int.parse(_shippingCost.text);
        print(check_integer_shipping_cost.toString());
      } on Exception catch (e) {
        message += 'ราคาการจัดส่งต้องเป็นตัวเลขเท่านั้น\n';
        setState(() {});
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('แจ้งเตือน'),
                content: Text("ราคาการจัดส่งต้องเป็นตัวเลขเท่านั้น"),
                actions: [
                  TextButton(onPressed: () =>
                  {
                    Navigator.of(context).pop()
                  }, child: Text("ตกลง"))
                ],
              ),
        );
      }
      try {
        check_integer_start_price = int.parse(_startPrice.text);
        print(check_integer_start_price.toString());
      } on Exception catch (e) {
        message += "- ราคาเริ่มต้นต้องเป็นต้วเลขเท่านั้น\n";
        setState(() {
          message += "- ราคาเริ่มต้นต้องเป็นต้วเลขเท่านั้น\n";
        });
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('แจ้งเตือน'),
                content: Text("ราคาเริ่มต้นต้องเป็นต้วเลขเท่านั้น"),
                actions: [
                  TextButton(onPressed: () =>
                  {
                    Navigator.of(context).pop()
                  }, child: Text("ตกลง"))
                ],
              ),
        );
      }

      if (_imageData.length > 0 &&
          _nameProduct.text != '' &&
          _detialProduct.text != '' &&
          _shippingCost.text != '' &&
          _startPrice.text != '' &&
          _inputEndTimeData != '' &&
          _inputEndDateData != '' &&
          _dataAuctionTypeValue != '' &&
          _productTypeValues != '' &&
          ShareData.bankAccountUser != null &&
          check_integer_shipping_cost != null &&
          check_integer_start_price != null) {

        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => Center(child: CircularProgressIndicator()),
        );

        // String url = 'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/create-product';
        String url = ConfigAPI().getCreateProducServerPost();

        final uri = Uri.parse(url);
        final request = http.MultipartRequest('POST', uri);

        List<dynamic> stream = [];
        List<dynamic> multiport = [];

        print("Length _imageData: " + _imageData.length.toString());

        if (kIsWeb) {
          print("\n\n\n\n" + "Web");
          // print(_imageData[0]! as PlatformFile);
          print("Web" + "\n\n\n\n\n");

          Map data = {"image_1": "ข้อมูลรูปภาพ"};

          for (int i = 0; i < _imageData.length; i++) {
            PlatformFile? _imageDataPlatformFile =
                _imageData[i] as PlatformFile;

            stream.add(_imageDataPlatformFile.bytes!);
            //
            multiport.add(
              http.MultipartFile.fromBytes(
                'image_${i + 1}', //image_1 -image_10
                stream[i],
                filename: _imageDataPlatformFile?.path.toString(),
              ),
            );

            request.files.add(multiport[i]);
            request.fields['image_${i + 1}'] = request.files[i].toString();
          }
        } else if (Platform.isAndroid) {
          for (int i = 0; i < _imageData.length; i++) {
            stream.add(File(_imageData[i]!.path.toString()).readAsBytesSync());

            multiport.add(
              http.MultipartFile.fromBytes(
                'image_${i + 1}',
                stream[i],
                filename: _imageData[i]!.path,
              ),
            );

            request.files.add(multiport[i]);
            request.fields['image_${i + 1}'] = request.files[i].toString();
          }
        }

        print("\n\n\n\n" + request.fields.toString() + "\n\n\n\n\n");

        Map<String, dynamic> data = {
          // "data" : "test",
          // "id_users": '2',
          "id_users": ShareData.userData['id_users'].toString(),
          // "id_product_types": _productTypeValues,
          "id_product_types": selectProductType(_productTypeValues),
          // "name_product": "Submit Flutter Test",
          "name_product": _nameProduct.text,
          // "detail_product": "Flutter Detail Test",
          "detail_product": _detialProduct.text,
          // "shipping_cost": "999",
          "shipping_cost": _shippingCost.text,
          // "start_price": "20",
          "start_price": _startPrice.text,
          // "end_date_time": "2025-04-25 01:26:00",
          "end_date_time": _inputEndDateData + " " + _inputEndTimeData,
          "id_auction_types": auctionTypes(_dataAuctionTypeValue),
          // "id_payment_types": ShareData.bankAccountUser['data']['id_payment_types'].toString(),
          "id_payment_types": '1',
          "id_bank_accounts": ShareData
              .bankAccountUser['id_bank_accounts'].toString(),
          // "id_bank_accounts": '1',
        };

        print("${data}");
        // print(ShareData.bankAccountUser['id_bank_accounts'].toString());

        request.fields['id_users'] = data['id_users'];
        request.fields['id_product_types'] = data['id_product_types'];
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text("เปิดประมูลสำเร็จ")),
          );

          print("\n\n\n");
          print("Successfully");
          print("\n\n\n");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuctionHome()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );

          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(title: Text("ล้มเหลว")),
          // );
          //
          print("\n\n\n");
          print("False Status Code: " + response.statusCode.toString());
          print("\n\n\n");
        }
      } else {
        setState(() {
          message = '';
        });

        // print(
        // "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS" + ShareData.userData.toString());
        if (ShareData.bankAccountUser == null) {
          setState(() {
            message += "- กรุณาเพิ่มบัญชีธนาคาร\n";
          });
        }
        if (_imageData.length <= 0) {
          setState(() {
            message += "- กรุณาเพิ่มรูปภาพอย่างน้อย 1 ภาพ\n";
          });
        }
        if (_dataAuctionTypeValue == null) {
          setState(() {
            message += "- กรุณาเลือกประเภทการประมูล\n";
          });
        }
        if (_productTypeValues == null) {
          setState(() {
            message += '- กรุณาเลือกประเภทสินค้า\n';
          });
        }
        if (_nameProduct.text == '') {
          setState(() {
            message += "- กรุณาเพิ่มชื่อสินค้า\n";
          });
        }
        if (_detialProduct.text == '') {
          setState(() {
            message += "- กรุณาเพิ่มรายละเอียดสินค้า\n";
          });
        }
        if (_shippingCost.text == '') {
          setState(() {
            message += "- กรุณาเพิ่มค่าจัดส่งสินค้า\n";
          });
        }
        if (_startPrice.text == '') {
          setState(() {
            message += "- กรุณาเพิ่มราคาเริ่มต้นประมูล\n";
          });
        }
        if (_inputEndTimeData == '') {
          setState(() {
            message += "- กรุณาเพิ่มเวลาปิดประมูล\n";
          });
        }
        if (_inputEndDateData == '') {
          setState(() {
            message += "- กรุณาเพิ่มวันที่ปิดประมูล\n";
          });
        }
        Navigator.of(context).pop();

        showDialog(context: context, builder: (context) =>
            AlertDialog(
              title: Text("แจ้งเตือน"),
              content: Text("${message}"),
              actions: [
                TextButton(onPressed: () =>
                {
                  Navigator.of(context).pop()
                }, child: Text("ตกลง"))
              ],
            ));
      }
    } on Exception catch (e) {
      print("\n\n\n");
      print("ERROR: " + e.toString());
      print("\n\n\n");

      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("แจ้งเตือน"),
              content: Text("เกิดข้อผิดพลาดกรุณาลองใหม่อีกครั้ง"),
            ),
      );
    }
  }

  TextStyle subjectTextStyle() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  }

  String selectProductType(String product_type) {
    List check_index_product_types = ProductTypesModel().getProductTypes();

    for (int index = 0; index <= check_index_product_types.length - 1; index++) {
      if (product_type == check_index_product_types[index]['product_type_text']) {
        return "${index + 1}";
      }
    }
    return "1";

    if (product_type == 'ทั่วไป') {
      return '1';
    } else if (product_type == 'ของเก่า') {
      return '2';
    } else if (product_type == 'เสื้อผ้า') {
      return '3';
    } else if (product_type == 'ของใช้') {
      return '4';
    } else if (product_type == 'เทคโนโลยี') {
      return '5';
    } else if (product_type == 'เครื่องดนตรี') {
      return '6';
    } else if (product_type == 'นาฬิกา') {
      return '7';
    } else if (product_type == 'เครื่องประดับ') {
      return '8';
    } else if (product_type == 'จักรยานยนต์') {
      return '9';
    } else if (product_type == 'รถยนต์') {
      return '10';
    }
    return '1';
  }

  String auctionTypes(String auction_types) {
    List check_index_auction_types = AuctionTypesModel().getAuctionTypes();
    for (int index = 0; index <= check_index_auction_types.length - 1; index++) {
      if (auction_types == check_index_auction_types[index]['auction_types']) {
        return "${index + 1}";
      }
    }

    return "1";

  //   if (auction_types == '') {
  //     return "1";
  //   } else if (_dataAuctionTypeValue == 'ประมูลปกติ') {
  //     return "1";
  //   } else if (_dataAuctionTypeValue == 'ประมูลแบบส่วนตัว') {
  //     return "2";
  //   }
  //   return "1";
  }

  void test() {

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
