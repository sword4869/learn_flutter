import 'package:flutter/material.dart';
import 'FilterChipDemo.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Flutter Demo',
    home: MyHome(),
  ));
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              ChipDemo(),
            ],
          ),
          Row(
            children: [
              InputChipDemo(),
              InputChipDemo2(),
            ],
          ),
          Row(
            children: [ChoiceChipDemo()],
          ),
          Row(
            children: [CastFilter()],
          ),
          Row(
            children: [ActionChipDemo()],
          )
        ],
      ),
    );
  }
}

class ChipDemo extends StatelessWidget {
  const ChipDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          label: const Text('Chip'),
        ),
        Chip(
          label: const Text('No Function'),
          // 在label前的圆形图标
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: const Text('AB'),
          ),
          // 阴影程度
          elevation: 10.0,
          // 阴影颜色
          shadowColor: Colors.indigo,
          backgroundColor: Colors.brown,
        )
      ],
    );
  }
}

class InputChipDemo extends StatelessWidget {
  const InputChipDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InputChip(
          label: Text('InputChip'),
        ),
        InputChip(
          label: const Text('OnPress'),
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('OnPress')));
          },
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: const Text('AB'),
          ),
          // 阴影程度
          elevation: 10.0,
          // 阴影颜色
          shadowColor: Colors.indigo,
          backgroundColor: Colors.brown,
        )
      ],
    );
  }
}

class InputChipDemo2 extends StatefulWidget {
  const InputChipDemo2({Key? key}) : super(key: key);

  @override
  State<InputChipDemo2> createState() => _InputChipDemo2State();
}

class _InputChipDemo2State extends State<InputChipDemo2> {
  bool _state = false;
  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text('onSelected'),
      // 还得绑定到 selected 属性
      selected: _state,
      onSelected: (bool v) {
        // 用setState()才有效果
        setState(() {
          _state = v;
        });
      },
    );
  }
}

class ChoiceChipDemo extends StatefulWidget {
  const ChoiceChipDemo({Key? key}) : super(key: key);

  @override
  State<ChoiceChipDemo> createState() => _ChoiceChipDemoState();
}

class _ChoiceChipDemoState extends State<ChoiceChipDemo> {
  int? _value = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        3,
        (int index) {
          return ChoiceChip(
            label: Text('Item $index'),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? index : null;
              });
              print(_value); // [0, n-1] 的一个数表示选中，null表示都没选
            },
          );
        },
      ).toList(),
    );
  }
}

class ActionChipDemo extends StatelessWidget {
  const ActionChipDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        child: const Text('AB'),
      ),
      label: const Text('Aaron Burr'),
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('OnPress')));
      },
    );
  }
}
