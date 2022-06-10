import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timehole/Entity/LowLabelEntity.dart';
import 'package:timehole/Entity/MyEntity.dart';
import 'MyDAO.dart';

class LowLabelDAO extends MyDAO {
  @override
  initiateTable(MyEntity myEntity) async {
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
              ll_id INTEGER PRIMARY KEY AUTOINCREMENT,
              ll_name TEXT,
              hl_id INTEGER,
              star INTEGER,
              CONSTRAINT fk_low_lable_table
              FOREIGN KEY (hl_id)
              REFERENCES high_label_table(hl_id)  
            );
            ''',
          );
        });
      },
    );
  }

  Future<LowLabelEntity> selectKeyId(MyEntity myEntity) async {
    Map map = await db.query(
      myEntity.table_name,
      where: "ll_id = ?",
      whereArgs: [myEntity.getKeyId()],
    );
    return LowLabelEntity.fromMap(map);
  }
}
