import 'package:flutter/material.dart';
import 'package:timehole/DAO/HighLabelDAO.dart';
import 'package:timehole/DAO/LowLabelDAO.dart';
import 'package:timehole/Entity/HighLabelEntity.dart';
import 'package:timehole/Entity/LowLabelEntity.dart';
import 'package:timehole/constraints.dart';

class ListLowLabelComponent extends StatefulWidget {
  late int ll_id;
  late int _index = -1;
  late List<LowLabelEntity> lists;

  ListLowLabelComponent({Key? key, required this.lists}) : super(key: key);

  @override
  State<ListLowLabelComponent> createState() => _ListLowLabelComponentState();
}

class _ListLowLabelComponentState extends State<ListLowLabelComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: List<Widget>.generate(
            widget.lists.length + 1,
            (int index) {
              if (index != widget.lists.length) {
                return ChoiceChip(
                  label: Text(
                    '${widget.lists[index].ll_name}',
                    style: myTextStyle_15,
                  ),
                  selected: widget._index == index,
                  onSelected: (bool selected) {
                    setState(() {
                      widget._index = selected ? index : -1;
                      widget.ll_id = widget.lists[index].ll_id;
                    });
                    print(
                        'selected : ${widget._index}'); // [0, n-1] 的一个数表示选中，-1表示都没选
                  },
                );
              } else {
                return ActionChip(
                  label: Icon(Icons.mode_edit_outline_rounded),
                  onPressed: () {
                    Navigator.pushNamed(context, 'LowLabelManagement',
                            arguments: widget.lists)
                        .then((value) {
                      setState(() {
                        widget.lists = value as List<LowLabelEntity>;
                      });
                    });
                  },
                );
              }
            },
          ).toList(),
        ),
      ],
    );
  }
}
