import 'package:flutter/material.dart';
import 'package:thread_project/home/screen/add_item.dart';
import '../../layout/default_layout.dart';
import '../widget/data_table_widget.dart';

const List<String> listItem = <String>[
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
  String dropdownValue = listItem.first;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return AddItemScreen(
                  IDNumber: dropdownValue.toString(),
                );
              }));
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
      title: "Home",
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropDownContainer(),
            DataTableWidget(),
          ],
        ),
      ),
    );
  }

  Container DropDownContainer() {
    return Container(
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
        items: listItem.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

