import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 接收settings参数
    dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(arguments['uid'].toString())),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 传回值
            Navigator.pop(context, {'name': 'ABC', 'age': 12});
          },
          child: Text("BackHome"),
        ),
      ),
    );
  }
}
