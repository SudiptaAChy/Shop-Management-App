import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jomakhoroch/Model/product.dart';
import 'package:jomakhoroch/View/edit_prod.dart';
import 'package:jomakhoroch/View/stock.dart';

class ProdDet extends StatefulWidget {
  final Product prod;
  ProdDet(this.prod);

  @override
  _ProdDetState createState() => _ProdDetState();
}

class _ProdDetState extends State<ProdDet> {
  final TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('পণ্যের বিস্তারিত', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.green,
              ),
              label: Text('এডিট করুন'),
              icon: Icon(Icons.edit, color: Colors.green),
              onPressed: () {
                Get.to(EditProd(widget.prod));
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[200],
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  (widget.prod.imgUrl == 'null')
                      ? Image.asset('images/box.png', height: 180)
                      : Image.network(widget.prod.imgUrl, height: 180),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(widget.prod.catagory,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(widget.prod.product,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0))),
                            Align(
                                alignment: Alignment.topRight,
                                child: Expanded(
                                    child: Text('৳${widget.prod.sell}',
                                        style: TextStyle(
                                            color: Colors.yellow[800])))),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('স্টক ${widget.prod.stock} পিস')),
                        SizedBox(height: 12.0),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'স্টক সংখ্যা লিখুন',
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 1.0)),
                                                    ),
                                                    controller:
                                                        stockController),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Products')
                                                        .doc(widget.prod.id)
                                                        .update({
                                                      'Stock': (int.parse(widget
                                                                  .prod.stock) +
                                                              int.parse(
                                                                  stockController
                                                                      .text))
                                                          .toString(),
                                                    }).then((value) {
                                                      Navigator.pop(context);
                                                      Get.to(Stock());
                                                    });
                                                  },
                                                  child: Text('যোগ করুন'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                    onPrimary: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                },
                                icon: Icon(Icons.add),
                                label: Text('স্টক যোগ করুন'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.share),
                                label: Text('শেয়ার করুন'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12.0),
                      ],
                    ),
                    SizedBox(height: 22.0),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('বিক্রয় মূল্য',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('৳${widget.prod.sell}')),
                            ])),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('পাইকারি বিক্রয় মূল্য',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('৳0.00')),
                            ])),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Text('ক্রয় মূল্য',
                                  style: TextStyle(color: Colors.grey)),
                              Text('৳${widget.prod.buy}'),
                            ])),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(children: [
                      Expanded(
                          flex: 1,
                          child: Column(children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('ভ্যাট',
                                    style: TextStyle(color: Colors.grey))),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('নাই')),
                          ])),
                      Expanded(
                          flex: 1,
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('ডিসকাউন্ট',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('${widget.prod.discount}')),
                          ])),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
