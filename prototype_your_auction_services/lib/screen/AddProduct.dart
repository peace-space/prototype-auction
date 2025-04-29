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
  List<File?> data = [];
  

  late List<File>? _selectImageData;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มสินค้า')),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            height: 250,
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.lightBlue,
            child: showImage(),
          ),
          // showImage(),
          Container(
            height: 500,
            width: double.infinity,
            color: Colors.red,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                nameProduct(),
                nameProduct(),
                startPriceProduct(),
                closeDateTimeAuction(),
                imageProduct(),
                SizedBox(height: 10),
                openAuctionButton(),
                SizedBox(height: 300),
              ],
            ),
          )
        ],
      )
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
      data.add(File(response!.path));
    });
  }

  void deleteSelectImage() {
    setState(() {
      data.removeAt(0);
    });
  }

  Widget showImage() {
    double left = 0.0;
    double top = 8.0;
    double right = 0.0;
    double bottom = 0.0;
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return GridTile(
          header: GridTileBar(
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () =>
                  {
                    deleteSelectImage()
                  },
                  child: Icon(Icons.delete),
                )
              ],
            ),
          ),
          child: (data == null)
              ? Image.network(
            'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public/storage/images/product-images/r8mNaVcgLItF3Y6Cm166JrbboAfbLMl2ert3znHL.png',
            fit: BoxFit.cover,)
              : Image.file(data[0]!),
        );
      },
    );
  }

  // Widget showImage() {
  //   double left = 0.0;
  //   double top = 8.0;
  //   double right = 0.0;
  //   double bottom = 0.0;
  //   return StreamBuilder(
  //     stream: null,
  //     builder: (context, snapshot) {
  //       return Container(
  //           color: Colors.red,
  //           width: 100,
  //           height: 400,
  //           child: ListView.builder(
  //             itemCount: data.length,
  //             itemBuilder: (context, index) {
  //               return Padding(
  //                 padding: EdgeInsets.fromLTRB(left, top, right, bottom),
  //                 child: (data == null)
  //                     ? Image.asset('image/temp.png')
  //                     : Image.file(data[index]!),
  //               );
  //             },
  //           )
  //       );
  //     },
  //   );
  // }

  Future<void> getLostData() async {}
}
