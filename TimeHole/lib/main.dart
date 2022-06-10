import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timehole/DAO/BlackHoleDAO.dart';
import 'package:timehole/DAO/LowLabelDAO.dart';
import 'package:timehole/Entity/BlackHoleEntity.dart';
import 'package:timehole/Entity/LowLabelEntity.dart';
import 'package:timehole/Page/BlackHole.dart';
import 'package:timehole/Page/ListBlackHole.dart';
import 'package:timehole/Page/LowLabelManagement.dart';
import 'package:timehole/constraints.dart';

void main() {
  // 注意，routes时，不能 const MaterialApp()
  runApp(MaterialApp(
    // 不需要也不能定义 home 了
    initialRoute: "/",
    routes: {
      // 根主页
      "/": (context) => const MyHome(),
      "BlackHole": (context) => BlackHole(),
      "LowLabelManagement": (context) => LowLabelManagement(),
      "ListBlackHole": (context) => ListBlackHole(),
    },
  ));
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: myGoldColor_dark,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the next page',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Next page'),
                      ),
                      body: const Center(
                        child: Text(
                          'This is the next page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ],
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  print("tap");
                },
                child: Icon(Icons.home),
              ),
              Text('Home'),
            ],
          )),
      body: Container(
        color: myBlackColor,
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: myGoldColor_dark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            tooltip: 'BlackHole',
            icon: const Icon(Icons.wb_incandescent_outlined),
            onPressed: () async {
              LowLabelEntity lowLabelEntity = LowLabelEntity.list();
              LowLabelDAO lowLabelDAO = LowLabelDAO();
              await lowLabelDAO.initiateTable(lowLabelEntity);
              List<Map> maps = await lowLabelDAO.listEntity(lowLabelEntity);
              await lowLabelDAO.close();

              List<LowLabelEntity> lists = <LowLabelEntity>[];
              maps.forEach((element) {
                lists.add(LowLabelEntity.fromMap(element));
              });

              Navigator.pushNamed(context, "BlackHole", arguments: lists);
            },
          ),
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              DateFormat outputFormat = DateFormat("yyyy-MM-dd");
              String dateInString = outputFormat.format(DateTime.now());

              BlackHoleEntity blackHoleEntity = BlackHoleEntity.list();
              BlackHoleDAO blackHoleDAO = BlackHoleDAO();
              await blackHoleDAO.initiateTable(blackHoleEntity);
              print('main-----${dateInString}-------');
              // lists 是DB返回的只读，还得复制一个新的，后面才能修改
              List<Map> lists =
                  await blackHoleDAO.selectLowlabelNameFormat(dateInString);
              await blackHoleDAO.close();
              // print('---------------------------');
              // print(lists[0].toString());
              List<Map> lists2 = <Map>[];
              lists.forEach((element) {
                lists2.add(element);
              });

              Navigator.pushNamed(context, "ListBlackHole", arguments: lists2);
            },
          ),
          IconButton(
            tooltip: 'Favorite',
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
