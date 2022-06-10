import 'package:flutter/material.dart';
import 'package:layout/MyMessage.dart';
import 'package:layout/SecondPage.dart';

void main() {
  // 注意，routes时，不能 const MaterialApp()
  runApp(MaterialApp(
    // 不需要也不能定义 home 了
    initialRoute: "/",
    routes: {
      // 根主页
      "/": (context) => const MyHome(),
      "SecondPage": (context) => const SecondPage(),
    },
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
            Navigator
                .pushNamed(context, "SecondPage", arguments: MyMessage("ABC", 1004))
                .then((value) {
                  print("value:${value}");
                });
          },
          child: Text("SecondPage"),
        ),
      ),
    );
  }
}
