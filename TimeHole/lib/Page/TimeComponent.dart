import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:intl/intl.dart';
import 'package:timehole/constraints.dart';

class TimePickerComponent extends StatefulWidget {
  late String title = '';
  late String time = '';

  TimePickerComponent({Key? key, required this.title}) : super(key: key);

  @override
  State<TimePickerComponent> createState() => _TimePickerComponentState();
}

class _TimePickerComponentState extends State<TimePickerComponent> {
  PDuration _pDuration = PDuration.now();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${widget.title}:${widget.time}',
            style: myTextStyle_20,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Pickers.showDatePicker(
                context,
                // 模式，详见下方
                mode: DateMode.YMDHM,
                // 后缀 默认Suffix.normal()，为空的话Suffix()
                suffix: Suffix(
                  years: ' 年',
                  month: ' 月',
                  days: ' 日',
                  hours: ' 时',
                  minutes: ' 分',
                ),
                // 样式  详见下方样式
                pickerStyle: RaisedPickerStyle.dark(),
                // 默认选中
                selectDate: _pDuration,
                onConfirm: (p) {
                  DateTime dateTime2 =
                      DateTime(p.year!, p.month!, p.day!, p.hour!, p.minute!);
                  DateFormat outputFormat = DateFormat("yyyy-MM-dd HH:mm");
                  String dateInString = outputFormat.format(dateTime2);
                  print('TimeComponent - dateInString: $dateInString');

                  setState(() {
                    _pDuration = p;
                    widget.time = dateInString;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
