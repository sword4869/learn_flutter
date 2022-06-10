import 'package:layout/MyEntity.dart';
import 'package:layout/DogEntity.dart';
import 'package:layout/MyDAO.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class DogDAO implements MyDAO {
  // 数据库名字
  static String db_name = 'my_database.db';

  @override
  late var db;

  // Future 同 Future<void>
  @override
  Future initiateTable(MyEntity myEntity) async {
    db = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), db_name),
      onOpen: (database) async {
        await database.transaction((txn) async {
          await txn.execute(
            '''
            CREATE TABLE if not exists ${myEntity.table_name}(
              dog_id INTEGER PRIMARY KEY AUTOINCREMENT,
              dog_name TEXT
            )
            ''',
          );
        });
      },
    );
  }

  @override
  Future close() async => db.close();

  // 并且设置好myEntity的主键id
  @override
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
  @override
  Future deleteEntity(MyEntity myEntity) async {
    await db.delete(
      myEntity.table_name,
      where: '${myEntity.key_id_name} = ?',
      whereArgs: [myEntity.getKeyId()],
    );
  }

  @override
  Future deleteTable(MyEntity myEntity) async {
    await db.transaction((txn) async {
      await txn.execute('''
      DROP TABLE ${myEntity.table_name}
      ''');
    });
  }

  @override
  Future<bool> deleteDB() async {
    if (db == null) {
      return false;
    }
    String path2 = join(await getDatabasesPath(), db_name);
    await deleteDatabase(path2);
    return true;
  }

  // 同理，更新没有该id的entity，不会报错
  @override
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

  @override
  Future<List<Map>> listEntity(MyEntity myEntity) async {
    // Query the table for all The Entities.
    List<Map> maps = await db.query(myEntity.table_name);
    return maps;
  }
}
