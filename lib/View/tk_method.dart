import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jomakhoroch/Controller/calculator_controller.dart';
import 'package:jomakhoroch/View/contact_list.dart';
import 'package:jomakhoroch/View/digital_payment.dart';
import 'package:jomakhoroch/View/kisti.dart';
import 'package:jomakhoroch/View/nogod_grohon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TkMethod extends StatefulWidget {
  const TkMethod({Key? key}) : super(key: key);

  @override
  _TkMethodState createState() => _TkMethodState();
}

class _TkMethodState extends State<TkMethod> {
  final CalculatorController calculatorController =
      Get.put(CalculatorController());

  void cashTap() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String sellerPhone = sharedPreferences.getString('Phone').toString();

    await FirebaseFirestore.instance.collection('Sales').doc().set({
      'Seller': sellerPhone,
      'Amount': calculatorController.totalSum.toString(),
      'Date': DateTime.now(),
      'Type': 'Cash',
      'Account': 'null',
      'Product': calculatorController.prodName.value.toString(),
    }).then((value) {
      Get.to(NagadGrohon());
    }).onError((error, stackTrace) {
      Get.snackbar('Error', error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title:
            Text('টাকা পরিশোধের মাধ্যম', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text('৳' + calculatorController.totalSum.toString(),
                  style: TextStyle(fontSize: 35.0)),
              Text('সর্বমোট'),
              SizedBox(height: 20.0),
              Align(alignment: Alignment.topLeft, child: Text('গৃহীত ক্যাশ')),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(calculatorController.totalSum.toString())),
              SizedBox(height: 10.0),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    tileColor: Colors.grey[200],
                    title: Text('নগদ গ্রহণ'),
                    leading: Icon(Icons.money),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: cashTap,
                  ),
                  SizedBox(height: 15.0),
                  ListTile(
                    tileColor: Colors.grey[200],
                    title: Text('ডিজিটাল পেমেন্ট'),
                    leading: Icon(Icons.mobile_friendly),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.to(DigitalPayment());
                    },
                  ),
                  SizedBox(height: 15.0),
                  ListTile(
                    tileColor: Colors.grey[200],
                    title: Text('বাকি রাখুন'),
                    leading: Icon(Icons.note),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.to(ContactList(true, false));
                    },
                  ),
                  SizedBox(height: 15.0),
                  ListTile(
                    tileColor: Colors.grey[200],
                    title: Text('কিস্তি'),
                    leading: Icon(Icons.calendar_today),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      //Get.to(Kisti());
                    },
                  ),
                  SizedBox(height: 15.0),
                  ListTile(
                    tileColor: Colors.grey[200],
                    title: Text('আপনার QR কোড সেট করুন'),
                    leading: Icon(Icons.qr_code),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
