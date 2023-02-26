import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late DatabaseReference dbRef;
  late StreamSubscription _dailySpecialStream;

  @override
  void initState() {
    super.initState();
    _activateListener();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 데이터 업데이트 성공시 스낵바 띄우기
  void _showSnackBar() {
    final snackBar = SnackBar(
        content: Text(
          " 🎉 SUCCESS UPLOAD! 🎉",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: "NotoSans",
          ),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // 데이터 업데이트 실패시 스낵바 띄우기
  void _errorShowSnackBar(Object error) {
    final snackBar = SnackBar(
        content: Text(
          " 😵 $error 😵",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: "NotoSans",
          ),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _activateListener() {
   dbRef = FirebaseDatabase.instance.ref().child('Employee');
   print("dbRef : $dbRef");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Test1"
        ),
      ),
    );
  }
}
