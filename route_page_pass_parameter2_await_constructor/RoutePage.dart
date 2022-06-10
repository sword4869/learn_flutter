import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  // 通过类的构造器来接收参数
  final int uid;
  const SecondPage({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar() 变成了一个返回按钮，其实已经提供回去的功能，所以其实不写 ElevatedButton
      appBar: AppBar(title: Text(this.uid.toString())),
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
