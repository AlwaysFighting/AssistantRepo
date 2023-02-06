import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;

  const DefaultLayout({
    Key? key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: actions,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: body,
      ),
    );
  }
}
