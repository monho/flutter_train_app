import 'package:flutter/material.dart';
import 'home/homepage.dart' as Homepage;

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기차예매',
      home: Homepage.Homepage(),
    );
  }
}
