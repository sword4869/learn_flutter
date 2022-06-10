import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:intl/intl.dart';
import 'package:timehole/DAO/BlackHoleDAO.dart';
import 'package:timehole/Entity/BlackHoleEntity.dart';
import 'package:timehole/Page/SimpleBarChar.dart';
import 'package:timehole/constraints.dart';

class ListBlackHole extends StatefulWidget {
  ListBlackHole({Key? key}) : super(key: key);

  @override
  State<ListBlackHole> createState() => _ListBlackHoleState();
}

class _ListBlackHoleState extends State<ListBlackHole> {
  bool listsFlag = false;
  String myTitle = '';
  late List<Map> lists;
  List<double> lists_difference = [];
  List<String> lists_difference_display_hour = [];
  List<String> lists_difference_display_minute = [];
  List<String> lists_start_time_display = [];
  List<String> lists_end_time_display = [];
  List<String> lists_description = [];
  List<String> lists_title_complete = [];
  List<String> lists_title_easy = [];
  PDuration _pDuration = PDuration.now();

  computation() {
    if (listsFlag) {
      DateFormat outputFormat = DateFormat("yyyy-MM-dd");
      String dateInString =
          outputFormat.format(DateTime.parse(lists[0]['start_time']));
      myTitle = dateInString;

      lists_difference.clear();
      lists_difference_display_hour.clear();
      lists_difference_display_minute.clear();
      lists_start_time_display.clear();
      lists_end_time_display.clear();
      lists_description.clear();
      lists_title_complete.clear();
      lists_title_easy.clear();
      lists.forEach((item) {
        // print('Test- ${item.start_time}');

        DateTime dateTime_start_time = DateTime.parse(item['start_time']);
        DateTime dateTime_end_time = DateTime.parse(item['end_time']);
        lists_start_time_display
            .add('${dateTime_start_time.hour}:${dateTime_start_time.minute}');
        lists_end_time_display
            .add('${dateTime_end_time.hour}:${dateTime_end_time.minute}');
        Duration difference_duration =
            dateTime_end_time.difference(dateTime_start_time);

        DateTime datetime_zero = DateTime(0);
        DateTime difference_datetime = datetime_zero.add(difference_duration);
        lists_difference_display_hour.add('${difference_datetime.hour}H');
        lists_difference_display_minute.add('${difference_datetime.minute}M');
        lists_difference.add(difference_duration.inMinutes.toDouble());

        String ll_name = item['ll_name'];
        String description = item['description'];

        lists_title_complete.add(ll_name);
        lists_title_easy.add(ll_name.length == 0 ? '' : ll_name[0]);
        lists_description.add(description);
      });
      // print('''
      //   lists_difference = $lists_difference
      //   lists_difference_display_hour = $lists_difference_display_hour
      //   lists_difference_display_minute = $lists_difference_display_minute
      //   lists_start_time_display = $lists_start_time_display
      //   lists_end_time_display = $lists_end_time_display
      //   lists_description = $lists_description
      //   lists_title_complete = $lists_title_complete
      //   lists_title_easy = $lists_title_easy
      //   ''');
    } else {
      DateFormat outputFormat = DateFormat("yyyy-MM-dd");
      String dateInString = outputFormat.format(DateTime.now());
      myTitle = dateInString;
    }
  }

  Widget getMyLeadingWidget(int index) {
    if (listsFlag) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    lists_start_time_display[index],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: myGoldColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Text(
                    lists_end_time_display[index],
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: myGoldColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    lists_difference_display_hour[index],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: myGoldColor,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w900,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Text(
                    lists_difference_display_minute[index],
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: myGoldColor,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w900,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return const Text('leading nothing');
    }
  }

  Widget getMyEndWidget(int index) {
    if (listsFlag) {
      return Container(
        child: Column(
          children: [
            Text(lists_title_complete[index],
                textAlign: TextAlign.left, style: myTextStyle_20),
            Text(
              lists_description[index],
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: myGoldColor,
                fontWeight: FontWeight.w900,
                fontSize: 10.0,
              ),
            ),
          ],
        ),
      );
    } else {
      return const Text('leading nothing');
    }
  }

  Widget getButton(int index) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text("EDIT"),
            value: 0,
          ),
          PopupMenuItem(
            child: Text("DELETE"),
            value: 1,
          ),
        ];
      },
      onSelected: (v) async {
        switch (v) {
          // EDIT
          case 0:
            {
              EditLowLabel(context, index);
              break;
            }
          // DELETE
          case 1:
            {
              BlackHoleEntity blackHoleEntity =
                  BlackHoleEntity.delete(lists[index]['b_id']);
              BlackHoleDAO blackHoleDAO = BlackHoleDAO();
              await blackHoleDAO.initiateTable(blackHoleEntity);
              await blackHoleDAO.deleteEntity(blackHoleEntity);
              await blackHoleDAO.close();

              setState(() {
                lists.removeAt(index);
              });
              break;
            }
          default:
            {
              print('switch-default-null operation...');
              break;
            }
        }
      },
    );
  }

  Widget getBarChart() {
    if (listsFlag) {
      // print(lists_title_complete);
      // print(lists_difference);
      Map<String, double> map9 =
          Map.fromIterables(lists_title_complete, lists_difference);
      List<String> lists_title_complete2 = [];
      List<String> lists_title_easy2 = [];
      List<double> lists_difference2 = [];
      map9.forEach((String key, double value) {
        lists_title_complete2.add(key);
        lists_title_easy2.add(key.length == 0 ? '' : key[0]);
        lists_difference2.add(value);
      });
      // print(map9);
      // print(lists_title_complete2);
      // print(lists_title_easy2);
      // print(lists_difference2);
      return BarChartSample1(
          lists_title_easy2, lists_title_complete2, lists_difference2);
    } else {
      return const Text('chart nothing');
    }
  }

  void EditLowLabel(BuildContext context, int index) async {
    String start_time = '';
    String end_time = '';
    int ll_id = -1;
    String ll_name = lists[index]['ll_name'];
    String description = '';
    bool my_flag = false;
    await showDialog<Object>(
      context: context,
      builder: (context) {
        TextEditingController _start_time = TextEditingController();
        _start_time.text = lists[index]['start_time'];
        TextEditingController _end_time = TextEditingController();
        _end_time.text = lists[index]['end_time'];
        TextEditingController _ll_id = TextEditingController();
        _ll_id.text = lists[index]['ll_id'].toString();
        TextEditingController _description = TextEditingController();
        _description.text = lists[index]['description'];
        return AlertDialog(
          title: const Text('BlackHoleManagement'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _start_time,
                  decoration: InputDecoration(
                    labelText: "start_time",
                  ),
                ),
                TextField(
                  controller: _end_time,
                  decoration: InputDecoration(
                    labelText: "end_time",
                  ),
                ),
                TextField(
                  controller: _ll_id,
                  decoration: InputDecoration(
                    labelText: "ll_id",
                  ),
                ),
                TextField(
                  controller: _description,
                  decoration: InputDecoration(
                    labelText: "description",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('SUBMIT'),
              onPressed: () {
                start_time = _start_time.text;
                end_time = _end_time.text;
                ll_id = int.parse(_ll_id.text);
                description = _description.text;
                my_flag = true;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    print('$start_time, $end_time, $ll_id, $description : [$my_flag]');

    int b_id = lists[index]['b_id'];
    if (my_flag) {
      BlackHoleEntity blackHoleEntity = BlackHoleEntity.update(
          b_id, start_time, end_time, ll_id, description);
      BlackHoleDAO blackHoleDAO = BlackHoleDAO();
      await blackHoleDAO.initiateTable(blackHoleEntity);
      await blackHoleDAO.updateEntity(blackHoleEntity);
      await blackHoleDAO.close();
      Map<String, dynamic> map2 = {
        'b_id': b_id,
        'start_time': start_time,
        'end_time': end_time,
        'll_id': ll_id,
        'll_name': ll_name,
        'description': description,
      };
      setState(() {
        lists.removeAt(index);
        lists.insert(index, map2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    lists = ModalRoute.of(context)?.settings.arguments as List<Map>;

    if (lists.isEmpty) {
      listsFlag = false;
    } else {
      listsFlag = true;
    }

    computation();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: myGoldColor_dark,
        title: Text(myTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.data_usage_rounded),
            tooltip: 'Selece DateTIme',
            onPressed: () {
              Pickers.showDatePicker(
                context,
                // 模式，详见下方
                mode: DateMode.YMD,
                // 后缀 默认Suffix.normal()，为空的话Suffix()
                suffix: Suffix(
                  years: ' 年',
                  month: ' 月',
                  days: ' 日',
                ),
                // 样式  详见下方样式
                pickerStyle: RaisedPickerStyle.dark(),
                // 默认选中
                selectDate: _pDuration,
                onConfirm: (p) async {
                  DateTime dateTime2 = DateTime(p.year!, p.month!, p.day!);
                  DateFormat outputFormat = DateFormat("yyyy-MM-dd");
                  String dateInString = outputFormat.format(dateTime2);
                  // print('ListBlackHole - dateInString: $dateInString');

                  BlackHoleEntity blackHoleEntity = BlackHoleEntity.list();
                  BlackHoleDAO blackHoleDAO = BlackHoleDAO();
                  await blackHoleDAO.initiateTable(blackHoleEntity);
                  print('-----${dateInString}-------');
                  // lists 是DB返回的只读，还得复制一个新的，后面才能修改
                  List<Map> lists2 =
                      await blackHoleDAO.selectLowlabelNameFormat(dateInString);
                  await blackHoleDAO.close();

                  setState(() {
                    _pDuration = p;
                    lists.clear();
                    lists2.forEach((element) {
                      lists.add(element);
                    });
                  });
                },
              );
            },
          ),
          // IconButton(onPressed: onPressed, icon: Icons.),
        ],
      ),
      body: Container(
        color: myBlackColor,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: getBarChart(),
            ),
            const Divider(
              thickness: 3,
              color: myGoldColor_dark,
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: ListView.builder(
                  itemCount: lists.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3.0,
                          color: myGoldColor,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: getMyLeadingWidget(index),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 5,
                            child: getMyEndWidget(index),
                          ),
                          getButton(index),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
