import 'package:flutter/material.dart';
import '../../layout/default_layout.dart';
import 'add_item.dart';

const List<String> dataItemList = <String>[
  "Item1",
  "Item2",
  "Item3",
  "Item4",
  "Item5",
  "Item6",
  "Item7",
  "Item8",
  "Item9",
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = dataItemList.first;
  String input = "";
  List dataItems = [];

  @override
  void initState() {
    super.initState();
    dataItems.add("Item1");
    dataItems.add("Item2");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      actions: [
        SizedBox(
          child: IconButton(
            onPressed: () {
              print("SAVE Click");
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
                          child: TextField(

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

  Widget DropDownContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: DropdownButton<String>(
        value: dropdownValue,
        hint: Text("Select Item"),
        icon: Icon(Icons.arrow_drop_down),
        alignment: Alignment.center,
        isExpanded: true,
        menuMaxHeight: 500.0,
        underline: Container(
          height: 1,
          color: Colors.grey,
        ),
        iconSize: 25,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: dataItemList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
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
          onPressed: () {},
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
