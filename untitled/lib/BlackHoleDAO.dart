import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:untitled/MyEntity.dart';
import 'MyDAO.dart';

class BlackHoleDAO extends MyDAO {
  @override
  initiateTable(MyEntity myEntity) async {
    db = await openDatabase(
      join(await getDatabasesPath(), db_name),
      onOpen: (database) async {
        await database.transaction((txn) async {
          await txn.execute(
            '''
            CREATE TABLE if not exists ${myEntity.table_name}(
              b_id INTEGER PRIMARY KEY AUTOINCREMENT,
              start_time TEXT,
              end_time TEXT,
              ll_id INTEGER,
              description TEXT,
              CONSTRAINT fk_blackhole_table
              FOREIGN KEY (ll_id)  
              REFERENCES low_lable_table(ll_id)  
            );
            ''',
          );
        });
      },
    );
  }

  Future<List<Map>> selectEntity(
      MyEntity myEntity, String selected_time) async {
    List<Map> maps = await db.query(
      myEntity.table_name,
      where: "strftime('%Y-%m-%d', start_time) = ?",
      whereArgs: [selected_time],
    );
    return maps;
  }
}
