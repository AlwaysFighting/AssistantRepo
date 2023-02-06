import 'package:flutter/material.dart';
import '../../layout/default_layout.dart';

class AddItemScreen extends StatelessWidget {
  final String IDNumber;

  final itemGroup = [1, 2, 3, 4, 5];

  AddItemScreen({
    Key? key,
    required this.IDNumber,
  }) : super(key: key);

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
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          width: 80,
        ),
      ],
      title: "기기 등록",
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: itemGroup.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Row(
              children: [
                Text(
                  'Entry ',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  'Entry ',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.teal;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
