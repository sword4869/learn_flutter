import 'package:timehole/Entity/MyEntity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class MyDAO {
  late var db;

  final String db_name = 'time_database.db';

  // Future 同 Future<void>
  Future initiateTable(MyEntity myEntity);

  Future close() async => db.close();

  // 并且设置好myEntity的主键id
  Future insertEntity(MyEntity myEntity) async {
    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    int id = await db.insert(
      myEntity.table_name,
      myEntity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    myEntity.setKeyId(id);
  }

  // 删了没有的主键entity，不会报错
  // 有1,2，然后删除了2，再自增主键是3，不会还是2.
  Future deleteEntity(MyEntity myEntity) async {
    await db.delete(
      myEntity.table_name,
      where: '${myEntity.key_id_name} = ?',
      whereArgs: [myEntity.getKeyId()],
    );
    print('DELETE ${myEntity.getKeyId()}');
  }

  Future deleteTable(MyEntity myEntity) async {
    await db.transaction((txn) async {
      await txn.execute('''
      DROP TABLE ${myEntity.table_name};
      ''');
    });
  }

  Future<bool> deleteDB() async {
    if (db == null) {
      return false;
    }
    String path2 = join(await getDatabasesPath(), db_name);
    await deleteDatabase(path2);
    return true;
  }

  Future<List<Map>> listEntity(MyEntity myEntity) async {
    // Query the table for all The Entities.
    List<Map> maps = await db.query(myEntity.table_name);
    return maps;
  }

  // 同理，更新没有该id的entity，不会报错
  Future updateEntity(MyEntity myEntity) async {
    // Update the given entity.
    await db.update(
      myEntity.table_name,
      myEntity.toMap(),
      // Ensure that the entity has a matching id.
      where: '${myEntity.key_id_name} = ?',
      // Pass the entity's id as a whereArg to prevent SQL injection.
      whereArgs: [myEntity.getKeyId()],
    );
  }
}
