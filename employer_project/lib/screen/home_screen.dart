import 'package:employer_project/screen/dashboard_screen.dart';
import 'package:employer_project/screen/data_detail_screen.dart';
import 'package:flutter/material.dart';

import '../widget/side_widget.dart';

class HomeScreen extends StatefulWidget {
  final int navPage;
  const HomeScreen({Key? key, required this.navPage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    // 네비게이션 탭 화면
    final List<Widget> _widgetOptions = <Widget>[
      const DashBoardScreen(),
      const DataDetailScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            const Expanded(
              child: SideMenuScreen(),
            ),
            Expanded(
              flex: 6,
              child: _widgetOptions[widget.navPage],
            )
          ],
        ),
      ),
    );
  }
}