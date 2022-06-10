import 'package:flutter/material.dart';
import 'package:layout/DogDAO.dart';
import 'package:layout/DogEntity.dart';
import 'package:layout/MyEntity.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Returning Data',
      home: Scaffold(
        appBar: AppBar(title: Text('Database')),
        body: MyHome(),
      ),
    ),
  );
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            // 不仅DAO内要异步，调用的时候也要异步，不然就会出现成员变量db没有初始化的问题
            onPressed: () async{
              DogEntity dogEntity = DogEntity.insert('X');
              DogDAO dogDao = DogDAO();
              await dogDao.initiateTable(dogEntity);
              await dogDao.insertEntity(dogEntity);
              await dogDao.close();
              print('dogEntity.getKeyId(): ${dogEntity.getKeyId()}');
            },
            child: Text('Insert')),
        ElevatedButton(
            onPressed: () async{
              DogEntity dogEntity = DogEntity.delete(2);
              DogDAO dogDao = DogDAO();
              await dogDao.initiateTable(dogEntity);
              await dogDao.deleteEntity(dogEntity);
              await dogDao.close();
            },
            child: Text('Delete Entity')),
        ElevatedButton(
            onPressed: () async{
              DogEntity dogEntity = DogEntity.list();
              DogDAO dogDao = DogDAO();
              await dogDao.initiateTable(dogEntity);
              await dogDao.deleteTable(dogEntity);
              await dogDao.close();
            },
            child: Text('Delete Table')),
        ElevatedButton(
            onPressed: () async{
              DogEntity dogEntity = DogEntity.list();
              DogDAO dogDao = DogDAO();
              await dogDao.initiateTable(dogEntity);
              bool flag = await dogDao.deleteDB();
              // 数据库都删了，还关什么？
              // await dogDao.close();
              print('flag: $flag');
            },
            child: Text('Delete Database')),
        ElevatedButton(
            onPressed: () async{
              DogEntity dogEntity = DogEntity.list();
              DogDAO dogDao = DogDAO();
              await dogDao.initiateTable(dogEntity);
              List<Map> maps = await dogDao.listEntity(dogEntity);
              await dogDao.close();
              var lists = <DogEntity>[];
              maps.forEach((element) {
                lists.add(DogEntity.fromMap(element));
              });
              print(lists.toString());
            },
            child: Text('List Table')),
        ElevatedButton(
            onPressed: () async{
              DogEntity dogEntity = DogEntity.update(2, 'Y');
              DogDAO dogDao = DogDAO();
              await dogDao.initiateTable(dogEntity);
              await dogDao.updateEntity(dogEntity);
              await dogDao.close();
            },
            child: Text('Update Table')),
      ],
    );
  }
}
