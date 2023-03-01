import 'package:flutter/material.dart';

import '../widget/side_widget.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SideMenuWidget(),
            ),
            Expanded(
              flex: 6,
              child: DashBoardScreen(),
            )
          ],
        ),
      ),
    );
  }
}