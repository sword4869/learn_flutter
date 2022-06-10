import 'package:flutter/material.dart';
import 'package:layout/SecondPage.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyHome(),
  ));
}

// 这种方法不行，会出现error：Navigator operation requested with a context that does not include a Navigator.
// context会向上查找到runApp()中，这种写法的最上层是 MyHome() 一个StatelessWidget，需要上面写法的 MaterialApp(), 这才是对的。
// void main() => runApp(MyHome());

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
              MaterialPageRoute(builder: (context) => const SecondPage()),
            );
          },
          child: Text("SecondPage"),
        ),
      ),
    );
  }
}
