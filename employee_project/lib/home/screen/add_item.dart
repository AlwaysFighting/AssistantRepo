import 'package:flutter/material.dart';
import '../../layout/default_layout.dart';

class AddItemScreen extends StatelessWidget {
  final String IDNumber;

  const AddItemScreen({
    Key? key,
    required this.IDNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "기기 등록",
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "기기 이름 : ",
                          style: TextStyle(
                              fontSize: 25.0
                          ),
                        ),
                        Text(
                          IDNumber,
                          style: TextStyle(
                              fontSize: 25.0
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
