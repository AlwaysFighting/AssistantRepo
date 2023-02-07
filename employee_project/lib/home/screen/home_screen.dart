import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../component/drawer_screen.dart';
import '../../const/operationNameLists.dart';
import '../../utils/data_utils.dart';

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
  String input = "";

  String dataListName = operationNameLists[0];
  int valueCount = 0;

  Map<String, String> dataKeyValues = {};

  final database = FirebaseDatabase.instance.reference();
  DateTime now = DateTime.now().toUtc();

  late StreamSubscription _dailySpecialStream;

  @override
  void initState() {
    super.initState();
    _activateListener();
  }

  void getKeysFromMap(Map map) {
    map.keys.forEach((key) {
      print(key);
    });
  }

  void getValuesFromMap(Map map) {
    map.values.forEach((value) {
      print(value);
    });
  }

  void getKeysAndValuesUsingForEach(Map map) {
    map.forEach((key, value) {
      for (int i = 0; i < valueCount; i++) {
        dataKeyValues.addEntries({"$key": "$value"}.entries);
      }
      print(dataKeyValues);
    });
  }

  void _activateListener() {
    _dailySpecialStream = database
        .child('${now.year}년-${now.month}월-${now.day}일/$dataListName/')
        .onChildAdded
        .listen((event) {
      // final Object? description = event.snapshot.value;
      final dataMap =
          Map<dynamic, dynamic>.from(event.snapshot.value as dynamic);
      setState(() {
        valueCount = dataMap.length;
        getKeysAndValuesUsingForEach(dataMap);
        print("valueCount : $valueCount");
      });
    });
  }

  // 값 추가하기
  void _activateUpdate(String key) {
    database
        .child(
            '/${now.year}년-${now.month}월-${now.day}일/$dataListName/${'${DataUtils.getTimeFormat(DateTime.now().hour)}시-${DataUtils.getTimeFormat(DateTime.now().minute)}분'}')
        .push()
        .set(key);
  }

  @override
  void deactivate() {
    _dailySpecialStream.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final dailyDataRef = database.child(
        '/${now.year}년-${now.month}월-${now.day}일/$dataListName/${'${DataUtils.getTimeFormat(DateTime.now().hour)}시-${DataUtils.getTimeFormat(DateTime.now().minute)}분'}');

    void _setData(Map map) async {
      for(int i = 0; i < dataKeyValues.length; i++){
        print('dataKeyValues.length ${dataKeyValues.length}');
        try {
          await dailyDataRef.set({
            '${map.keys.first}': '${map.keys.last}',
          }).then((_) => print("UPLOAD SUCCESS"));
        } catch (e) {
          print("You get error $e");
        }
      }
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
                "SAVE",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
              ),
            ),
            width: 80,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add Function"),
                content: TextField(
                  onChanged: (String value) {
                    input = value;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        dataKeyValues.addEntries({"$input": "0"}.entries);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("ADD"),
                  )
                ],
              );
            },
          );
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
        child: ListView.builder(
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
                        Expanded(child: Text( "keyItems[]" + "$index")),
                        Expanded(
                          child: TextFormField(
                            initialValue: "",
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
      ), drawer:  DrawerScreen(
      onRegionTap: (String region) {
        setState(() {
            this.dataListName = region;
            dataKeyValues = {}; // 저장 배열 공간 초기화
            _activateListener();
          });
          Navigator.of(context).pop();
        },
      selectedRegion: dataListName,
    ),
    );
  }

}