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
      "/": (context) => MyHome(
            messages: List.generate(
              20,
              (i) => MyMessage('Person $i', i),
            ),
          ),
      "SecondPage": (context) => const SecondPage(),
    },
  ));
}

class MyHome extends StatelessWidget {
  // 消息列表
  final List<MyMessage> messages;

  // 注意是required this.messages，而不是 required List<MyMessage> messages
  const MyHome({Key? key, required this.messages}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: ListView.builder(
          // ListView长度就是 List的元素个数
          itemCount: messages.length,
          // 既有 context，又有对应列表项的 index
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(messages[index].name),
              // 点击列表项，跳转到对应的详情界面
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "SecondPage",
                  arguments: messages[index],
                ).then((value) => print("value = ${value}"));
              },
            );
          },
        ),
      ),
    );
  }
}
