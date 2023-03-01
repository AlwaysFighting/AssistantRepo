import 'package:employer_project/screen/home_screen.dart';
import 'package:flutter/material.dart';

class SideMenuScreen extends StatelessWidget {
  const SideMenuScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    const textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    return Drawer(
      backgroundColor: Colors.blueGrey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return const HomeScreen(navPage: 0);
                  },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            leading: const Icon(Icons.home_filled, color: Colors.white,),
            title: const Text("홈", style: textStyle),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return const HomeScreen(navPage: 1);
                  },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            leading: const Icon(Icons.bar_chart, color: Colors.white),
            title: const Text("데이터 분석", style: textStyle),
          ),
        ],
      ),
    );
  }
}
