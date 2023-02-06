import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: SingleChildScrollView(
        child: Container(
          child: DataTable(
            dividerThickness: 1.0,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    '기기 이름',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    '값',
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  ),
                ),
              ),
            ],
            rows: const <DataRow> [
              DataRow(
                cells: <DataCell> [
                  DataCell(
                      Text('Sarah')
                  ),
                  DataCell(
                    TextField(

                    ),
                  ),
                ],
              ),
              DataRow(
                cells: <DataCell> [
                  DataCell(Text('Janine')),
                  DataCell(
                    TextField(
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
