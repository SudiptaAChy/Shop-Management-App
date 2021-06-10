import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jomakhoroch/Controller/contact_list_controller.dart';
import 'package:jomakhoroch/Model/contact.dart';
import 'package:jomakhoroch/View/contact_list.dart';
import 'package:jomakhoroch/View/edit_contact.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ContactDetails extends StatefulWidget {
  final Contact contact;
  const ContactDetails(this.contact);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  void phoneCall() async {
    await UrlLauncher.launch('tel:+${widget.contact.phone}');
  }

  void sentSms() async {
    await UrlLauncher.launch('sms:+${widget.contact.phone}');
  }

  void sentMail() async {
    await UrlLauncher.launch('mailto:+${widget.contact.email}');
  }

  Widget partOne() {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(70.0)),
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.black, width: 5.0),
                ),
                child: (widget.contact.imageUrl.isEmpty ||
                        widget.contact.imageUrl == '' ||
                        widget.contact.imageUrl == 'null')
                    ? Image.asset('images/contact.png')
                    : Image.network(widget.contact.imageUrl,
                        height: 120, width: 120, fit: BoxFit.contain),
              ),
              SizedBox(height: 10.0),
              Text(widget.contact.name, style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 5.0),
              Text(widget.contact.phone, style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 5.0),
              Container(
                color: Colors.yellow[800],
                child: Text(widget.contact.type,
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        phoneCall();
                      },
                      child: Card(
                        elevation: 0.0,
                        color: Colors.green[50],
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Icon(Icons.call, color: Colors.green),
                              Text('কল', style: TextStyle(color: Colors.green))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        sentSms();
                      },
                      child: Card(
                        elevation: 0.0,
                        color: Colors.green[50],
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Icon(Icons.message, color: Colors.green),
                              Text('মেসেজ',
                                  style: TextStyle(color: Colors.green))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        sentMail();
                      },
                      child: Card(
                        elevation: 0.0,
                        color: Colors.green[50],
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Icon(Icons.mail, color: Colors.green),
                              Text('মেইল',
                                  style: TextStyle(color: Colors.green))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget partTwo() {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('অন্যান্য তথ্যাবলী',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('ইমেইল')),
                  Expanded(
                      flex: 3,
                      child: (widget.contact.email.isEmpty ||
                              widget.contact.email == '')
                          ? Text('N/A')
                          : Text(widget.contact.email)),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('ঠিকানা')),
                  Expanded(
                      flex: 3,
                      child: (widget.contact.address.isEmpty ||
                              widget.contact.address == '')
                          ? Text('N/A')
                          : Text(widget.contact.address)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget partThree() {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('নোট',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(height: 15.0),
              Align(
                  alignment: Alignment.topLeft,
                  child:
                      (widget.contact.note == '' || widget.contact.note.isEmpty)
                          ? Text('N/A')
                          : Text(widget.contact.note)),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTap() async {
    await FirebaseFirestore.instance
        .collection('Contacts')
        .doc(widget.contact.id)
        .delete()
        .then((value) {
      Get.delete<ContactListController>();
      Get.off(ContactList(false, true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('কন্টাক্ট ডিটেলস', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(EditContact(widget.contact));
              },
              icon: Icon(Icons.edit, color: Colors.green)),
          PopupMenuButton(
              offset: Offset(0, 40),
              onSelected: (value) {
                if (value.toString() == 'delete') {
                  deleteTap();
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red[900]),
                        Expanded(child: Text('ডিলিট')),
                      ],
                    ),
                  )
                ];
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8.0),
            partOne(),
            partTwo(),
            partThree(),
          ],
        ),
      ),
    );
  }
}
