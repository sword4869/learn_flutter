import 'package:flutter/material.dart';

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
          ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                firstDate: DateTime(2022, 4, 18),
                initialDate: DateTime(2022, 4, 19),
                lastDate: DateTime(2022, 4, 30),
              ).then((value) {
                print(value.runtimeType);
                print('value = $value');
              });
            },
            child: Text('年-月-日'),
          ),
          ElevatedButton(
            onPressed: () {
              showTimePicker(
                initialTime: TimeOfDay(hour: 23, minute: 11),
                context: context,
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child!,
                  );
                },
              ).then((value) {
                print(value.runtimeType);
                print('value = $value');
              });
            },
            child: Text('时-分'),
          ),
        ],
      ),
    );
  }
}
