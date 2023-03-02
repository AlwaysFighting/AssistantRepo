import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String inputKey = "";
  String inputValue = "";

  Map<int, String> listDataKey = {};
  Map<int, String> listDataValue = {};

  Map<dynamic, dynamic> dataKeyValues = {};

  int valueCount = 0;

  final database = FirebaseDatabase.instance.reference();
  DateTime now = DateTime.now().toUtc();

  late StreamSubscription _dailySpecialStream;
  late StreamSubscription _itemListStream;

  List<String?> operationNameLists = [];
  String dataListName = "AA10001";

  // DateFormat 년,월,일 형식 지정하기
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    _activateListener();
  }

  // 맵의 key, value 불러오기
  void getKeysAndValuesUsingForEach(Map map) {
    map.forEach((key, value) {
      for (int i = 0; i < map.length; i++) {
        dataKeyValues.addEntries({"$key": "$value"}.entries);
      }
    });
    print(dataKeyValues);
  }

  void _activateListener() {
    _dailySpecialStream = database
        .child(
            'Employee/')
        .onChildAdded
        .listen((event) {
      final dataMap =
          Map<dynamic, dynamic>.from(event.snapshot.value as dynamic);
      setState(() {
        valueCount = dataMap.length;
        getKeysAndValuesUsingForEach(dataMap);
        // print(dataMap);
      });
    });

    _itemListStream = database.child('itemList').onValue.listen((event) {
      final listItemMap = List<String?>.from(event.snapshot.value as dynamic);
      setState(() {
        operationNameLists = listItemMap;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    _dailySpecialStream.cancel();
    _itemListStream.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
                    columnSpacing: 40,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    columns: [
                      DataColumn(label: Text("ID")),
                      DataColumn(label: Text("기기 이름")),
                      DataColumn(label: Text("업로드 최종 날짜")),
                      DataColumn(label: Text("업로드 최종 시간")),
                      DataColumn(label: Text("기능1")),
                      DataColumn(label: Text("기능2")),
                      DataColumn(label: Text("기능3")),
                    ],
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell> [
                          DataCell(Text("0")),
                          DataCell(Text("AA10001")),
                          DataCell(Text("2022-02-27")),
                          DataCell(Text("02:50")),
                          DataCell(Text("count : 50")),
                          DataCell(Text("temperture : 100")),
                          DataCell(Text("Null")),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text("1")),
                          DataCell(Text("AA10002")),
                          DataCell(Text("2022-02-27")),
                          DataCell(Text("03:02")),
                          DataCell(Text("count : 80")),
                          DataCell(Text("temperture : 40")),
                          DataCell(Text("rotation : 30")),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
