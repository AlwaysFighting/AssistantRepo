import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataDetailScreen extends StatefulWidget {
  final String? title;

  const DataDetailScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<DataDetailScreen> createState() => _DataDetailScreenState();
}

class _DataDetailScreenState extends State<DataDetailScreen> {
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
  // DateFormat 시,분,초 지정하기
  DateFormat dateTimeFormat = DateFormat("kk:mm");

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
  }

  void _activateListener() async {
    _itemListStream = database
        .child('itemList')
        .onValue
        .listen((event) {
      final listItemMap =
      List<String?>.from(event.snapshot.value as dynamic);
      setState(() {
        operationNameLists = listItemMap;
      });
    });

    final itemRef = FirebaseDatabase.instance.ref();

    final snapshot = await itemRef.child('itemListValues/$dataListName').get();
    if(snapshot.exists) {
      getKeysAndValuesUsingForEach(snapshot.value as Map);
      print("dataKeyValues: ${dataKeyValues.keys}");
    } else {
      print("No data..");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    _itemListStream.cancel();
    super.deactivate();
  }

  // 데이터 업데이트 성공시 스낵바 띄우기
  void _showSnackBar() {
    const snackBar = SnackBar(
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
          style: const TextStyle(
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
        '/Item-TimeStamp/$dataListName/${dateFormat.format(DateTime.now())}/${dateTimeFormat.format(DateTime.now())}');
    final addDataListRef = database.child('itemListValues/$dataListName/');

    // 데이터 업데이트하기
    void _setData(Map map) {
      map.forEach((key, value) async {
        for (int i = 0; i < map.length; i++) {
          try {
            await dailyDataRef.update({
              '$key': '$value',
            });
            await addDataListRef.update({
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
        backgroundColor: Colors.white,
        title: Text(dataListName),
        actions: [
          SizedBox(
            width: 80,
            child: IconButton(
              onPressed: () async {
                _setData(dataKeyValues);
              },
              icon: const Text(
                "저장",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: "NotoSans",
                ),
              ),
            ),
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
                title: const Text("기능 추가하기"),
                content: SizedBox(
                  height: 80,
                  child: Column(
                    children: [
                      const SizedBox(height: 17),
                      TextField(
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '기기 이름 작성하기',
                            hintStyle: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey[10],
                              fontFamily: "NotoSans",
                            ),
                            labelStyle: const TextStyle(
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
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await addDataListRef.update({
                        inputKey : "0"
                      });
                      setState(() {
                        dataKeyValues.addEntries({inputKey: "0"}.entries);
                      });
                    },
                    child: const Text("업로드"),
                  )
                ],
              );
            },
          );
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 100.0),
        child: Column(
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
                    margin: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
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