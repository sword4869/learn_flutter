# StatelessWidget

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

MyApp 继承自 StatelessWidget 。
我们重写MyApp 的 build 方法，返回 MaterialApp()。

MaterialApp 必不可少的是 home 。
home 使用 Scaffold，使用 appBar 和 body。
appBar 使用 AppBar

appBar: AppBar(
    title: const Text('Bar'),
),
body: Center(
    child: Text('Hello Android'),
),

# StatefulWidget

```dart
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

我们需要修改 _MyAppState 的 build 方法。



# 内容组件

Text('ABC'),
Icon(Icons.add),
Image.asset("images/a.jpg"),
Image.network("https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png")

RaisedButton(onPressed: (){},),
FlatButton(onPressed: (){}, child: Text('Flat'),),
IconButton(onPressed: (){}, icon: Icon(Icons.home)),
GestureDetector(
  onTap: () {
    print("tap");
  },
  onDoubleTap: () {
    print("double tap");
  },
  child: Icon(Icons.home),
),

Checkbox(
    value: _check_flag,
    onChanged: (v) {
      setState(() {
        _check_flag = v;
      });
    },
),


LinearProgressIndicator(),
CircularProgressIndicator(),


类似Toast，`..`表示和of同级，都是ScafflodMessenger的子类，而不是of的子类
先移除，再添加。这样就不会卡死。另外，之前没有还移出，不会报错
ScaffoldMessenger.of(context)
  ..removeCurrentSnackBar()
  ..showSnackBar(SnackBar(content: Text("${_user.text},${_pwd.text}")));

# 布局组件

Column(children: [],);
Container(child: Text('ABC');