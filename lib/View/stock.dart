import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jomakhoroch/Controller/stock_controller.dart';
import 'package:jomakhoroch/View/catagory_list.dart';
import 'package:jomakhoroch/View/stock_list.dart';

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  final StockController stockController = Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text('স্টক', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'স্টক লিস্ট'),
              Tab(text: 'ক্যাটাগরি লিস্ট'),
            ],
          ),
        ),
        body: Obx(
          () => (stockController.isLoad.value)
              ? Center(child: CircularProgressIndicator(color: Colors.green))
              : TabBarView(
                  children: [
                    StockList(
                        stockController.productList,
                        stockController.totalP.value,
                        stockController.cntB.value,
                        stockController.totalB.value),
                    CatagoryList(stockController.catList),
                  ],
                ),
        ),
      ),
    );
  }
}
