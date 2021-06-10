import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jomakhoroch/Controller/my_profile_controller.dart';
import 'package:jomakhoroch/View/bakir_khata.dart';
import 'package:jomakhoroch/View/becha_bikri.dart';
import 'package:jomakhoroch/View/bikrir_khata.dart';
import 'package:jomakhoroch/View/contact_list.dart';
import 'package:jomakhoroch/View/dashboard.dart';
import 'package:jomakhoroch/View/digital_payment.dart';
import 'package:jomakhoroch/View/marketing.dart';
import 'package:jomakhoroch/View/online_store.dart';
import 'package:jomakhoroch/View/report.dart';
import 'package:jomakhoroch/View/stock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = 'Name';

  void fetchData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String sellerPhone = sharedPreferences.getString('Phone').toString();

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(sellerPhone)
        .get()
        .then((value) {
      setState(() {
        name = value['Name'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: ListTile(
            leading: Container(
                color: Colors.grey[200],
                child: Image.asset('images/profile.png')),
            title: Text(name,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle:
                Text('বেসিক প্যাকেজ', style: TextStyle(color: Colors.white)),
          ),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              SizedBox(
                height: 15.0,
              ),
              Container(
                //width: 335,
                child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(BechaBikri());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 80,
                                      width: 50,
                                      child:
                                          Image.asset("images/calculator.png")),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "বেচা-বিক্রি",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(BakirKhata());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 80,
                                      width: 50,
                                      child:
                                          Image.asset("images/bakirkhata.jpg")),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "বাকীর খাতা",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(DigitalPayment());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 60,
                                      width: 70,
                                      child:
                                          Image.asset("images/collection.png")),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "ডিজিটাল কালেকশন",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(OnlineStore());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 90,
                                      width: 60,
                                      child:
                                          Image.asset("images/onlineshop.png")),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "অনলাইন স্টোর ",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(DashBoard());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 90,
                                      width: 60,
                                      child:
                                          Image.asset("images/dashboard.png")),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "ড্যাশবোর্ড",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 8, 0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "আরও",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
              ),
              Divider(
                height: 40,
                thickness: 2,
                color: Colors.black,
                indent: 32,
                endIndent: 32,
              ),
              Container(
                child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(BikrirKhata());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 35,
                                      width: 40,
                                      child: Image.asset("images/bikri.png")),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "বিক্রির খাতা",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(ContactList(false, true));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 35,
                                      width: 40,
                                      child: Image.asset("images/contact.png")),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "কনটাক্ট লিস্ট",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(Marketing());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 35,
                                      width: 40,
                                      child: Image.asset("images/promo.png")),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "মার্কেটিং ও প্রোমো",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(Report());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 35,
                                      width: 40,
                                      child: Image.asset("images/report.png")),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "রিপোর্ট",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(Stock());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 50,
                                      width: 35,
                                      child: Image.asset("images/stock.png")),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "স্টক",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Get.to(DashBoard());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 35,
                                      width: 40,
                                      child:
                                          Image.asset("images/hisabkhata.png")),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "হিসাব খাতা",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
