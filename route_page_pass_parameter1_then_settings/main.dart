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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondPage(),
                // 通过setting传入参数
                settings: RouteSettings(
                  name: "home",
                  arguments: {'uid': 1001},
                ),
              ),
              // 通过then来接收返回值
            ).then((value) => print("value:${value}"));
          },
          child: Text("SecondPage"),
        ),
      ),
    );
  }
}
