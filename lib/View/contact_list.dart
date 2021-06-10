import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jomakhoroch/Controller/calculator_controller.dart';
import 'package:jomakhoroch/Controller/contact_list_controller.dart';
import 'package:jomakhoroch/Model/contact.dart';
import 'package:jomakhoroch/View/add_contact.dart';
import 'package:jomakhoroch/View/baki_rakhun.dart';
import 'package:jomakhoroch/View/contact_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactList extends StatefulWidget {
  final bool bakiache, details;
  const ContactList(this.bakiache, this.details);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactListController contactListController =
      Get.put(ContactListController());
  final CalculatorController calculatorController =
      Get.put(CalculatorController());

  tileTap(String phone, Contact contact) async {
    print(widget.bakiache.toString() + ' = ' + widget.details.toString());

    if (widget.details == true) {
      Get.to(ContactDetails(contact));
    } else if (widget.bakiache == true) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String sellerPhone = sharedPreferences.getString('Phone').toString();
      await FirebaseFirestore.instance.collection('Sales').doc().set({
        'Seller': sellerPhone,
        'Amount': calculatorController.totalSum.toString(),
        'Date': DateTime.now(),
        'Type': 'Debt',
        'Account': phone,
        'Product': calculatorController.prodName.value.toString(),
      }).then((value) {
        Get.to(BakiRakhun());
      });
    } else {
      // ********** //
    }
  }

  @override
  void initState() {
    print(widget.bakiache.toString() + ' = ' + widget.details.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('নতুন কন্টাক্ট'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          if (widget.bakiache == true) {
            Get.to(AddContact('Baki'));
          } else {
            Get.to(AddContact('none'));
          }
        },
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('কন্টাক্ট লিস্ট', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        //color: Colors.grey[400],
        height: MediaQuery.of(context).size.height,
        child: Obx(() {
          if (contactListController.isLoad.value == true) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: contactListController.contactList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: () {
                      tileTap(
                          contactListController.contactList[index].phone
                              .toString(),
                          contactListController.contactList[index]);
                    },
                    tileColor: Colors.white,
                    leading: Container(
                      height: 60,
                      width: 60,
                      child: (contactListController.contactList[index].imageUrl
                                  .toString() ==
                              'null')
                          ? Image.asset('images/contact.png')
                          : Image.network(contactListController
                              .contactList[index].imageUrl),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Colors.green),
                    title: Text(contactListController.contactList[index].name
                        .toString()),
                    subtitle: Row(
                      children: [
                        Text(contactListController.contactList[index].phone
                            .toString()),
                        SizedBox(width: 5.0),
                        Container(
                            color: Colors.yellow[800],
                            child: Text(
                              contactListController.contactList[index].type
                                  .toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
