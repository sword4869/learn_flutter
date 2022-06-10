import 'package:flutter/material.dart';
import 'package:timehole/Page/ListLowlabelComponent.dart';
import 'package:timehole/Page/TimeComponent.dart';
import 'package:timehole/DAO/BlackHoleDAO.dart';
import 'package:timehole/Entity/BlackHoleEntity.dart';
import 'package:timehole/constraints.dart';

class BlackHole extends StatelessWidget {
  TextEditingController _description = TextEditingController();
  TimePickerComponent t1 = TimePickerComponent(title: '开始时间');
  TimePickerComponent t2 = TimePickerComponent(title: '结束时间');
  late ListLowLabelComponent l1;

  BlackHole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    l1 = ListLowLabelComponent(lists: arguments);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myGoldColor_dark,
        title: const Text("BlackHole"),
      ),
      body: Container(
        color: myBlackColor,
        child: Column(
          children: [
            t1,
            t2,
            l1,
            TextField(
              controller: _description,
              decoration: InputDecoration(
                // 账号图标
                prefixIcon: Icon(Icons.description),
                // 上方小字
                // 直接就是String类型，不用Text()
                labelText: "Description",
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                String start_time = t1.time;
                String end_time = t2.time;
                int ll_id = l1.ll_id;

                BlackHoleEntity blackHoleEntity = BlackHoleEntity.insert(
                    start_time, end_time, ll_id, _description.text);
                BlackHoleDAO blackHoleDAO = BlackHoleDAO();
                await blackHoleDAO.initiateTable(blackHoleEntity);
                await blackHoleDAO.insertEntity(blackHoleEntity);
                print(blackHoleEntity.toString());
                await blackHoleDAO.close();
              },
              child: Text('SUBMIT'),
            ),
          ],
        ),
      ),
    );
  }
}
