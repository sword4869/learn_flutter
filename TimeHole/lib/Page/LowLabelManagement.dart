import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:timehole/DAO/HighLabelDAO.dart';
import 'package:timehole/DAO/LowLabelDAO.dart';
import 'package:timehole/Entity/HighLabelEntity.dart';
import 'package:timehole/Entity/LowLabelEntity.dart';

class LowLabelManagement extends StatefulWidget {
  const LowLabelManagement({Key? key}) : super(key: key);

  @override
  State<LowLabelManagement> createState() => _LowLabelManagementState();
}

class _LowLabelManagementState extends State<LowLabelManagement> {
  late List<LowLabelEntity> messages;

  PreferredSizeWidget CreateMyAppBar(BuildContext context) {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          print('leading is working!!!');
          Navigator.pop(context, messages);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add_box),
          onPressed: () async {
            String ll_name = '';
            int hl_id = 0;
            bool star = true;
            bool my_flag = false;
            await showDialog<Object>(
              context: context,
              builder: (context) {
                TextEditingController _name = TextEditingController();
                TextEditingController _id = TextEditingController();
                TextEditingController _star = TextEditingController();
                return AlertDialog(
                  title: const Text('LowLabelManagement'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: _id,
                          decoration: InputDecoration(
                            labelText: "hl_id",
                          ),
                        ),
                        TextField(
                          controller: _name,
                          decoration: InputDecoration(
                            labelText: "ll_name",
                          ),
                        ),
                        TextField(
                          controller: _star,
                          decoration: InputDecoration(
                            labelText: "star",
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('SUBMIT'),
                      onPressed: () {
                        ll_name = _name.text;
                        hl_id = int.parse(_id.text);
                        star = int.parse(_star.text) == 0 ? false : true;
                        my_flag = true;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
            print('$ll_name, $hl_id, $star: [$my_flag]');
            if (my_flag) {
              LowLabelEntity lowLabelEntity =
                  LowLabelEntity.insert(ll_name, hl_id, star);
              LowLabelDAO lowLabelDAO = LowLabelDAO();
              await lowLabelDAO.initiateTable(lowLabelEntity);
              await lowLabelDAO.insertEntity(lowLabelEntity);
              await lowLabelDAO.close();
              setState(() {
                messages.add(lowLabelEntity);
              });
            }
          },
        ),
      ],
    );
  }

  EditLowLabel(context, int index) async {
    LowLabelEntity lowLabelEntity = messages[index];
    String ll_name = '';
    int hl_id = 0;
    bool star = true;
    bool my_flag = false;
    await showDialog<Object>(
      context: context,
      builder: (context) {
        TextEditingController _name = TextEditingController();
        _name.text = lowLabelEntity.ll_name;
        TextEditingController _id = TextEditingController();
        _id.text = lowLabelEntity.hl_id.toString();
        TextEditingController _star = TextEditingController();
        _star.text = lowLabelEntity.star == true ? '1' : '0';
        return AlertDialog(
          title: const Text('LowLabelManagement'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _id,
                  decoration: InputDecoration(
                    labelText: "hl_id",
                  ),
                ),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: "ll_name",
                  ),
                ),
                TextField(
                  controller: _star,
                  decoration: InputDecoration(
                    labelText: "star",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('SUBMIT'),
              onPressed: () {
                ll_name = _name.text;
                hl_id = int.parse(_id.text);
                star = int.parse(_star.text) == 0 ? false : true;
                my_flag = true;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    print('$ll_name, $hl_id, $star: [$my_flag]');
    if (my_flag) {
      LowLabelEntity lowLabelEntity2 =
          LowLabelEntity.update(lowLabelEntity.ll_id, ll_name, hl_id, star);
      LowLabelDAO lowLabelDAO = LowLabelDAO();
      await lowLabelDAO.initiateTable(lowLabelEntity2);
      await lowLabelDAO.updateEntity(lowLabelEntity2);
      await lowLabelDAO.close();
      setState(() {
        messages.removeAt(index);
        messages.insert(index, lowLabelEntity2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    messages =
        ModalRoute.of(context)?.settings.arguments as List<LowLabelEntity>;

    return WillPopScope(
      child: Scaffold(
        appBar: CreateMyAppBar(context),
        body: ListView.builder(
          // ListView长度就是 List的元素个数
          itemCount: messages.length,
          // 既有 context，又有对应列表项的 index
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(messages[index].ll_name),
              // 点击列表项，跳转到对应的详情界面
              trailing: Wrap(children: [
                PopupMenuButton(
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
                          LowLabelEntity lowLabelEntity =
                              LowLabelEntity.delete(messages[index].ll_id);
                          LowLabelDAO lowLabelDAO = LowLabelDAO();
                          await lowLabelDAO.initiateTable(lowLabelEntity);
                          await lowLabelDAO.deleteEntity(lowLabelEntity);
                          await lowLabelDAO.close();

                          setState(() {
                            messages.removeAt(index);
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
                ),
              ]),
            );
          },
        ),
      ),
      onWillPop: () async {
        print('onWillPop is working!!');
        if (Navigator.canPop(context)) {
          Navigator.pop(context, messages);
        } else {
          SystemNavigator.pop();
        }
        return Future.value(false);
      },
    );
  }
}
