import 'package:flutter/material.dart';
import 'package:layout/SecondPage.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyHome(),
  ));
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
          // 异步操作，等待返回值
          onPressed: () async {
            // 接受返回值，注意 await
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                // 通过类的构造器，传入参数
                builder: (context) => const SecondPage(uid: 1002),
              ),
            );
            print("result:${result}");
          },
          child: Text("SecondPage"),
        ),
      ),
    );
  }
}
