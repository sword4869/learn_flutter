import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal List'),
      ),
      body: ListView(
        // 横向
        scrollDirection: Axis.horizontal,
        children: List.generate(
          10,
          (index) => VerticalDivider(thickness: 50, width: 100),
        ),
      ),
    );
  }
}
