import 'package:flutter/material.dart';
import 'home/screen/home_screen.dart';

void main() {

  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
