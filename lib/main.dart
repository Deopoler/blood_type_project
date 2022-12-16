import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '혈액형 프로젝트',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        fontFamily: 'NotoSansKR',
        scaffoldBackgroundColor: Colors.black12,
      ),
      home: const Home(),
    );
  }
}
