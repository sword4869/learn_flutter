import 'package:flutter/material.dart';
import 'package:layout/MyMessage.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 接收settings参数，并且转化为MyMessage类
    // 这里是final，因为 as 转为 MyMessage类了
    final arguments = ModalRoute.of(context)?.settings.arguments as MyMessage;
    return Scaffold(
      appBar: AppBar(title: Text(arguments.name + arguments.age.toString())),
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
