import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jomakhoroch/Model/Baki.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BakiController extends GetxController {
  List<Baki> bakiList = List<Baki>.empty(growable: true).obs;
  var isLoad = true.obs;
  var totalBaki = '0'.obs;
  var totalJoma = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }

  void getProduct() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String sellerPhone = sharedPreferences.getString('Phone').toString();

    FirebaseFirestore instance = FirebaseFirestore.instance;
    var qSnap = await instance
        .collection('Sales')
        .where('Seller', isEqualTo: sellerPhone)
        .get();

    List<Baki> pList = List<Baki>.empty(growable: true);
    Set<String> phonenoList = {};

    for (int i = 0; i < qSnap.docs.length; i++) {
      phonenoList.add(qSnap.docs[i]['Account'].toString());

      if (qSnap.docs[i]['Type'].toString() == 'Debt') {
        totalBaki.value = (double.parse(totalBaki.value) +
                double.parse(qSnap.docs[i]['Amount'].toString()))
            .toString();
      } else {
        totalJoma.value = (double.parse(totalJoma.value) +
                double.parse(qSnap.docs[i]['Amount'].toString()))
            .toString();
      }
    }

    phonenoList.forEach((element) {
      double total = 0.0;
      for (int i = 0; i < qSnap.docs.length; i++) {
        if (qSnap.docs[i]['Account'] == element) {
          if (qSnap.docs[i]['Type'].toString() == 'Debt') {
            total = total + double.parse(qSnap.docs[i]['Amount']);
          }
        }
      }
      if (total > 0.0) pList.add(Baki(element, total.toString()));
    });

    // for (int i = 0; i < qSnap.docs.length; i++) {
    //   if (qSnap.docs[i]['Type'] == 'Debt') {
    //     totalBaki.value = (double.parse(totalBaki.value) +
    //             double.parse(qSnap.docs[i]['Amount']))
    //         .toString();
    //   }

    //   phonenoList.add(qSnap.docs[i]['Account'].toString());

    //   pList.add(Baki(
    //     qSnap.docs[i]['Account'],
    //     qSnap.docs[i]['Seller'],
    //     qSnap.docs[i]['Amount'],
    //     qSnap.docs[i]['Date'].toString(),
    //     qSnap.docs[i]['Type'],
    //   ));
    // }

    bakiList = pList;
    isLoad.value = false;
  }
}
