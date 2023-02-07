import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../layout/default_layout.dart';
import '../../utils/data_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String input = "";
  List<String> dataItems = [];

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
    final dailySpecialRef = database.child(
        '/${currentDate.year}년-${currentDate.month}월-${currentDate.day}일/item1');

    return DefaultLayout(
      actions: [
        SizedBox(
          child: IconButton(
            onPressed: () async {
              try {
                await dailySpecialRef.set({
                  'List1': 'gel',
                  'value': 5,
                  'TimeStamp': '${DataUtils.getTimeFormat(
                      currentDate.hour)}시-${DataUtils.getTimeFormat(
                      currentDate.minute)}분',
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
      title: "Home",
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
      ),
    );
  }
}


class SaveButton extends StatelessWidget {
  const SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: ElevatedButton(
          onPressed: () {

          },
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
            height: 300.0,
            child: Text(
              "SAVE",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
            ),
          )),
    );
  }
}
