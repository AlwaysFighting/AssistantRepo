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
  List<String> dataItems = [];
  String dataListName = operationNameLists[0];

  final database = FirebaseDatabase.instance.reference();
  DateTime currentDate = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();

    dataItems.add("value");
    dataItems.add("value2");
  }

  @override
  Widget build(BuildContext context) {
    final dailyDataRef = database.child(
        '/${currentDate.year}년-${currentDate.month}월-${currentDate.day}일/$dataListName/${'${DataUtils.getTimeFormat(
            DateTime.now().hour)}시-${DataUtils.getTimeFormat(
            DateTime.now().minute)}분'}');
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(dataListName),
        actions: [
          SizedBox(
            child: IconButton(
              onPressed: () async {
                try {
                  await dailyDataRef.set({
                    'List1': 'gel',
                    'value': 5,
                  }).then((_) => print("UPLOAD SUCCESS"));
                } catch (e) {
                  print("You get error $e");
                }
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
                title: Text("기능 추가하기"),
                content: TextField(
                  onChanged: (String value) {
                    input = value;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        dataItems.add(input);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("추가하기"),
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
          itemCount: dataItems.length,
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
                        Expanded(child: Text(dataItems[index])),
                        Expanded(
                          child: TextFormField(
                            initialValue: dataItems[index],
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {

                            },
                            icon: Icon(Icons.delete_outlined),
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
        });
        Navigator.of(context).pop();
      },
      selectedRegion: dataListName,
    ),
    );
  }
}