import 'package:flutter/material.dart';

class SideMenuWidget extends StatelessWidget {
  SideMenuWidget({
    super.key,
  });

  final selectedTextStyle = TextStyle(
    color: Colors.teal,
    fontWeight: FontWeight.w700,
    fontSize: 13,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            onTap: (){

            },
            leading: Icon(Icons.home_filled,),
            title: Text("홈"),
            selectedColor: Colors.teal,
          ),
          ListTile(
            onTap: (){},
            leading: Icon(Icons.bar_chart),
            title: Text("데이터 분석"),
          ),
        ],
      ),
    );
  }
}
