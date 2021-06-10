import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jomakhoroch/Model/product.dart';
import 'package:jomakhoroch/View/add_products.dart';
import 'package:jomakhoroch/View/prod_det.dart';

class StockList extends StatefulWidget {
  final List<Product> pList;
  final int totalP, cntB;
  final String totalB;
  const StockList(this.pList, this.totalP, this.cntB, this.totalB);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('নতুন পণ্য'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(AddProducts('Stock'));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15.0, left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Text('মোট ${widget.totalP}টি',
                          style: TextStyle(color: Colors.grey))),
                  Align(
                      alignment: Alignment.topRight,
                      child: Expanded(
                          child: Text('ক্রয়মূল্য ৳${widget.totalB}',
                              style: TextStyle(color: Colors.grey)))),
                ],
              ),
            ),
            Divider(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.pList.length,
              itemBuilder: (BuildContext context, int index) => Column(
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(ProdDet(widget.pList[index]));
                    },
                    title: Text(widget.pList[index].product,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('স্টক ${widget.pList[index].stock} পিস',
                                style: TextStyle(color: Colors.grey))),
                        (widget.pList[index].online == 'true')
                            ? Align(
                                alignment: Alignment.topLeft,
                                child: Text('Published',
                                    style: TextStyle(color: Colors.green)),
                              )
                            : Align(
                                alignment: Alignment.topLeft,
                                child: Text('unpublished',
                                    style: TextStyle(color: Colors.red)),
                              ),
                      ],
                    ),
                    trailing: Text('৳' + widget.pList[index].sell),
                    leading: (widget.pList[index].imgUrl == 'null' ||
                            widget.pList[index].imgUrl == null)
                        ? Image.asset('images/box.png',
                            height: 50.0, width: 50.0)
                        : Image.network(widget.pList[index].imgUrl,
                            height: 50.0, width: 50.0),
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
