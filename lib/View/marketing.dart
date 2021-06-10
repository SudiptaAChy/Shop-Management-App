import 'package:flutter/material.dart';

class Marketing extends StatefulWidget {
  const Marketing({Key? key}) : super(key: key);

  @override
  _MarketingState createState() => _MarketingState();
}

class _MarketingState extends State<Marketing> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('মার্কেটিং এর জন্য কল করুন ০১৮২০০৬৬৬৬২',
              style: TextStyle(fontSize: 25.0)),
        ),
      ),
    );
  }
}
