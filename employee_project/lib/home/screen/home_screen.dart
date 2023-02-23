import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final String? title;

  HomeScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  String dataListName = "서울";

  // DateFormat 년,월,일 형식 지정하기
  DateFormat dateFormat = DateFormat("yyyy년 MM월 dd일");
  // DateFormat 시,분,초 지정하기
  DateFormat dateTimeFormat = DateFormat("kk시 mm분 ss초 a");

  @override
  void initState() {
    super.initState();
    _activateListener();
  }

  void getKeysFromMap(Map map) {
    map.forEach((key, value) {
      for (int i = 0; i < valueCount; i++) {}
    });
  }

  void getValuesFromMap(Map map) {
    map.values.forEach((value) {
      print(value);
    });
  }

  // 맵의 key, value 불러오기
  void getKeysAndValuesUsingForEach(Map map) {
    map.forEach((key, value) {
      for (int i = 0; i < map.length; i++) {
        dataKeyValues.addEntries({"$key": "$value"}.entries);
      }
    });
  }

  void _activateListener() {
    _dailySpecialStream = database
        .child('${dateFormat.format(DateTime.now())}/$dataListName/')
        .onChildAdded
        .listen((event) {
      final dataMap =
          Map<dynamic, dynamic>.from(event.snapshot.value as dynamic);
      setState(() {
        valueCount = dataMap.length;
        getKeysAndValuesUsingForEach(dataMap);
        print("dataMap : $dataMap");
      });
    });

    _itemListStream = database
        .child('itemList')
        .onValue
        .listen((event) {
      final listItemMap =
      List<String?>.from(event.snapshot.value as dynamic);
      setState(() {
        operationNameLists = listItemMap;
        print("listItemMap : $listItemMap");
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

  @override
  Widget build(BuildContext context) {
    final dailyDataRef = database.child(
        '/${dateFormat.format(DateTime.now())}/$dataListName/${dateTimeFormat.format(DateTime.now())}');

    // 데이터 업데이트하기
    void _setData(Map map) {
      print(map);
      map.forEach((key, value) async {
        for (int i = 0; i < map.length; i++) {
          try {
            await dailyDataRef.update({
              '$key': '$value',
            });
          } catch (e) {
            _errorShowSnackBar(e);
          }
        }
      });
      _showSnackBar();
      _activateListener();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(dataListName),
        actions: [
          SizedBox(
            child: IconButton(
              onPressed: () async {
                _setData(dataKeyValues);
              },
              icon: const Text(
                "저장",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "NotoSans",
                ),
              ),
            ),
            width: 80,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print(keysList);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("기능 추가하기"),
                content: Container(
                  height: 80,
                  child: Column(
                    children: [
                      SizedBox(height: 17),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '기기 이름 작성하기',
                            hintStyle: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey[10],
                              fontFamily: "NotoSans",
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black54,
                              fontFamily: "NotoSans",
                            )),
                        onChanged: (String key) {
                          inputKey = key;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        dataKeyValues.addEntries({"$inputKey": "0"}.entries);
                        print("dataKeyValues : $dataKeyValues");
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("업로드"),
                  )
                ],
              );
            },
          );
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 50, 22, 0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: dataListName,
              icon: const Icon(Icons.arrow_drop_down),
              menuMaxHeight:400,
              elevation: 1,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'NotoSans',
              ),
              onChanged: (String? value) {
                setState(() {
                  dataListName = value!;
                  dataKeyValues.clear(); // 저장 배열 공간 초기화
                  _activateListener();
                });
              },
              items: operationNameLists
                  .map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: dataKeyValues.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.all(5.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                    "${dataKeyValues.keys.elementAt(index)}")),
                            Expanded(
                              child: TextFormField(
                                onChanged: (String text) {
                                  dataKeyValues[dataKeyValues.keys
                                      .elementAt(index)] = text;
                                },
                                initialValue:
                                    "${dataKeyValues.values.elementAt(index)}",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Container buildButton(BuildContext context, String text) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 6,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "NotoSans",
          ),
        ),
      ),
    ),
  );
}