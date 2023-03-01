import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 80.0),
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
                    rows: [
                      DataRow(cells: [
                        DataCell(Text("0")),
                        DataCell(Text("AA10001")),
                        DataCell(Text("2022-02-27")),
                        DataCell(Text("02:50")),
                        DataCell(Text("count : 50")),
                        DataCell(Text("temperture : 100")),
                        DataCell(Text("Null")),
                      ]),
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
