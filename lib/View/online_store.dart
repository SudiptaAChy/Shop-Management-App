import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jomakhoroch/Controller/online_store_controller.dart';
import 'package:jomakhoroch/View/add_products.dart';
import 'package:jomakhoroch/View/stock.dart';
import 'package:jomakhoroch/View/subs.dart';

class OnlineStore extends StatefulWidget {
  const OnlineStore({Key? key}) : super(key: key);

  @override
  _OnlineStoreState createState() => _OnlineStoreState();
}

class _OnlineStoreState extends State<OnlineStore> {
  final OnlineStoreController onlineStoreController =
      Get.put(OnlineStoreController());

  Widget buildButton(Function, String text, IconData icon1, IconData icon2) {
    return ElevatedButton.icon(
      onPressed: Function,
      icon: Icon(icon1),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        minimumSize: Size(MediaQuery.of(context).size.width * 0.925, 50),
        alignment: Alignment(-1, 0),
      ),
    );
  }

  Widget buildCard(String text1, String text2) {
    return Card(
      shape: RoundedRectangleBorder(
        side: (text1 == 'মোট অর্ডার' || text1 == 'মোট বিক্রি')
            ? BorderSide.none
            : BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: (text1 == 'মোট অর্ডার')
          ? Colors.blue[100]
          : ((text1 == 'মোট বিক্রি') ? Colors.brown[100] : Colors.green[100]),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(text1, style: TextStyle(fontSize: 14.0))),
            SizedBox(height: 5.0),
            Align(
                alignment: Alignment.topLeft,
                child: Text(text2, style: TextStyle(fontSize: 22.0))),
          ],
        ),
      ),
    );
  }

  void settingBtn() {
    Get.to(Subs());
  }

  void addBtn() {
    Get.to(AddProducts('none'));
  }

  void infoBtn() {
    Get.to(Subs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('অনলাইন স্টোর', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
              offset: Offset(0, 40),
              onSelected: (value) {
                if (value.toString() == 'faq') {
                  Get.to(Subs());
                } else if (value.toString() == 'how') {
                  Get.to(Subs());
                } else if (value.toString() == 'store-settings') {
                  Get.to(Subs());
                } else if (value.toString() == 'share') {
                  //
                } else if (value.toString() == 'product') {
                  Get.to(Stock());
                } else if (value.toString() == 'order') {
                  // have to do
                } else {
                  // have to do
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'faq',
                    child: Row(
                      children: [
                        Icon(Icons.question_answer_outlined,
                            color: Colors.green),
                        Expanded(
                            child: Text('অনলাইন স্টোরে সম্পর্কে বিস্তারিত')),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'how',
                    child: Row(
                      children: [
                        Icon(Icons.video_call, color: Colors.green),
                        Text('কিভাবে ব্যবহার করব'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'store-settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings, color: Colors.green),
                        Text('স্টোর সেটিংস'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'product',
                    child: Row(
                      children: [
                        Icon(Icons.add_box_outlined, color: Colors.green),
                        Text('পণ্যের লিস্ট'),
                      ],
                    ),
                  ),
                ];
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildButton(settingBtn, 'অনলাইন স্টোরে সেটিং', Icons.settings,
                    Icons.arrow_forward_ios_outlined),
                SizedBox(height: 10.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('অনলাইন স্টোরের হিসাব',
                                style: TextStyle(fontSize: 14.0))),
                        Row(
                          children: [
                            Expanded(
                              child: buildCard('মোট অর্ডার', '0'),
                            ),
                            Expanded(
                              child: buildCard('মোট বিক্রি', '0'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('বর্তমান অর্ডার',
                                style: TextStyle(fontSize: 14.0))),
                        Row(
                          children: [
                            Expanded(
                              child: buildCard('নতুন', '0'),
                            ),
                            Expanded(
                              child: buildCard('চলতি কমপ্লিট', '0'),
                            ),
                            Expanded(
                              child: buildCard('কমপ্লিট', '0'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Get.to(Stock());
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('পণ্যের হিসাব',
                                  style: TextStyle(fontSize: 14.0))),
                          Row(
                            children: [
                              Expanded(
                                child: buildCard('মোট পণ্য',
                                    onlineStoreController.totalProd.toString()),
                              ),
                              Expanded(
                                child: buildCard(
                                    'পাবলিশড পণ্য',
                                    onlineStoreController.onlineProd
                                        .toString()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                buildButton(addBtn, 'নতুন পণ্য যোগ করুন', Icons.add_box,
                    Icons.add_circle_outline),
                SizedBox(height: 10.0),
                buildButton(addBtn, 'অনলাইন স্টোরে সম্পর্কিত তথ্য',
                    Icons.question_answer, Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*


 */