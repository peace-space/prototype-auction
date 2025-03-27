import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  State<AddProduct> createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {
  File? _selectedImage;

  late List<File>? _selectImageData;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มสินค้า')),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          nameProduct(),
          nameProduct(),
          startPriceProduct(),
          closeDateTimeAuction(),
          imageProduct(),
          showImage(),
          Text("เพิ่มรูปที่ 2"),
          Text("เพิ่มรูปที่ 3"),
          SizedBox(height: 10),
          openAuctionButton(),
        ],
      ),
    );
  }

  Widget nameProduct() {
    return TextField(decoration: InputDecoration(hintText: "ชื่อสินค้า"));
  }

  Widget detailProduct() {
    return TextField(decoration: InputDecoration(hintText: "รายละเอียดสินค้า"));
  }

  Widget startPriceProduct() {
    return TextField(decoration: InputDecoration(hintText: "ราคาเริ่มต้น"));
  }

  Widget closeDateTimeAuction() {
    return TextField(decoration: InputDecoration(hintText: "วันเวลาปิดประมูล"));
  }

  Widget imageProduct() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => {selectImage()},
          child: Text("เพิ่มรูป"),
        ),
        ElevatedButton(
          onPressed: () => {deleteSelectImage()},
          child: Text("ลบ"),
        ),
      ],
    );
  }

  Widget openAuctionButton() {
    return ElevatedButton(
      onPressed: () => {selectImage()},
      child: Text("เปิดประมูล"),
    );
  }

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (response == null) {
      return;
    }
    setState(() {
      _selectedImage = File(response!.path);
    });
  }

  void deleteSelectImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Widget showImage() {
    return Container(
      width: 100,
      height: 400,
      child:
          _selectedImage == null
              ? Image.asset('image/temp.png')
              : Image.file(_selectedImage!),
    );
  }

  Future<void> getLostData() async {}
}
