import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timehole/Entity/BlackHoleEntity.dart';
import 'package:timehole/Entity/LowLabelEntity.dart';
import 'package:timehole/Entity/MyEntity.dart';
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

  Future<List<Map>> selectYMD(
      BlackHoleEntity blackHoleEntit, String selected_time) async {
    List<Map> maps = <Map>[];
    await db.transaction((txn) async {
      maps = await txn.query(
        blackHoleEntit.table_name,
        where: "strftime('%Y-%m-%d', start_time) = ?",
        whereArgs: [selected_time],
      );
    });
    return maps;
  }

  Future<List<Map>> selectLowlabelNameFormat(String selected_time) async {
    BlackHoleEntity blackHoleEntity = BlackHoleEntity.list();
    LowLabelEntity lowLabelEntity = LowLabelEntity.list();

    List<Map> maps = <Map>[];
    await db.transaction((txn) async {
      maps = await txn.rawQuery(
        """
        SELECT b.b_id as b_id, b.start_time as start_time, b.end_time as end_time,l.ll_id as ll_id, l.ll_name as ll_name, b.description as description
        FROM ${blackHoleEntity.table_name} as b
        LEFT JOIN ${lowLabelEntity.table_name} as l
        ON b.ll_id = l.ll_id
        where strftime('%Y-%m-%d', start_time) = ?
        ;
        """,
        [selected_time],
      );
    });
    return maps;
  }
}
