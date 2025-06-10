import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  State<AddProduct> createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มสินค้า')),
      body: StreamBuilder(
        stream: null,
        builder:
            (context, snapshot) =>
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                children: [
                  showOneImage(),
                  showAndSelectImage(),
                  selectShowImage(),
                  SizedBox(
                    height: 8,
                  ),
                  inputImageProduct(),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  inputDataProduct(),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  inputBankAccount(),
                  SizedBox(
                    height: 8,
                  ),
                  buttonSubmit(),

                  SizedBox(
                    height: 500,
                  )
                ],
                )
            ),
      ),
    );
  }

  Widget showOneImage() {
    return Container(
        width: 500,
        height: 300,
        child: Image.network(
          "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image/car-001.jpg",
          fit: BoxFit.fill,)
    );
  }

  Widget showAndSelectImage() {
    return Container(
      width: 100,
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) =>
              Card(
                child: InkWell(
                  onTap: () => {},
                  child: Image.network(
                    "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image/car-001.jpg",
                    fit: BoxFit.fill,),
                ),
              )
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
              onPressed: () => {},
              icon: Icon(Icons.arrow_back_sharp)
          ),
          // Text("Start"),
          Text("8/10"),
          // Text("End"),
          IconButton(
              onPressed: () => {},
              icon: Icon(Icons.arrow_forward_sharp)
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
            "เพิ่มข้อมูลสินค้าเพื่อเปิดประมูล", style: subjectTextStyle(),),
        ),
        SizedBox(
          height: 8,
        ),
        Text("ประเภทการประมูล", style: subjectTextStyle(),),
        inputAuctionTypes(),
        SizedBox(
          height: 8,
        ),
        Text("ชื่อสินค้า:", style: subjectTextStyle(),),
        inputNameProduct(),
        SizedBox(
          height: 8,
        ),
        Text("รายละเอียดสินค้า:", style: subjectTextStyle(),),
        inputDetailProduct(),
        SizedBox(
          height: 8,
        ),
        Text("ค่าจัดส่ง:", style: subjectTextStyle(),),
        inputShippingCost(),
        SizedBox(
          height: 8,
        ),
        Text("ราคาเริ่มต้น", style: subjectTextStyle(),),
        inputStartPrice(),
        SizedBox(
          height: 8,
        ),
        Text("เวลาปิดประมูล ( วัน : ชั่วโมง : นาที : วินาที )",
          style: subjectTextStyle(),),
        inputEndDateTime(),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget inputImageProduct() {
    return ElevatedButton(
        onPressed: () => {},
        child: Text("inputImageProduct")
    );
  }

  Widget inputNameProduct() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "ชื่อสินค้า"
      ),
    );
  }

  Widget inputDetailProduct() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "รายละเอียดสินค้า"
      ),
    );
  }

  Widget inputShippingCost() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "inputShippingCost"
      ),
    );
  }

  Widget inputStartPrice() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "inputStartPrice"
      ),
    );
  }

  Widget inputEndDateTime() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "inputEndDateTime"
      ),
    );
  }

  Widget inputAuctionTypes() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "inputAuctionTypes"
      ),
    );
  }

  Widget inputBankAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text("inputBankAccount", style: subjectTextStyle(),),
        ),
        SizedBox(
          height: 8,
        ),
        Text("ประเภทการชำระเงิน", style: subjectTextStyle(),),
        inputPaymentTypes(),
        SizedBox(
          height: 8,
        ),
        Text("ชื่อบัญชีธนาคาร", style: subjectTextStyle(),),
        inputNameBankAccount(),
        SizedBox(
          height: 8,
        ),
        Text("เลขบัญชีธนาคาร", style: subjectTextStyle(),),
        inputBankAccountNumber(),
        SizedBox(
          height: 8,
        ),
        Text("พร้อมเพย์", style: subjectTextStyle(),),
        inputPromptPay(),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget inputPaymentTypes() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "inputPaymentTypes"
      ),
    );
  }

  Widget inputBankAccountNumber() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "inputBankAccountNumber"
      ),
    );
  }

  Widget inputNameBankAccount() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "inputNameBankAccount"
      ),
    );
  }

  Widget inputPromptPay() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "inputPromptPay"
      ),
    );
  }

  Widget buttonSubmit() {
    return ElevatedButton(
        onPressed: () => {}, 
        child: Text("เปิดประมูล")
    );
  }

  TextStyle subjectTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18
    );
  }
}
