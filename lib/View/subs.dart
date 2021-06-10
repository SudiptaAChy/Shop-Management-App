import 'package:flutter/material.dart';

class Subs extends StatefulWidget {
  const Subs({Key? key}) : super(key: key);

  @override
  _SubsState createState() => _SubsState();
}

class _SubsState extends State<Subs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('যেকোনো প্রয়োজনে ফোন করুন ০১৮২০০৬৬৬৬২',
              style: TextStyle(fontSize: 25.0)),
        ),
      ),
    );
  }
}
