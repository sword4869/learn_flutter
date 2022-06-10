import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timehole/Entity/MyEntity.dart';
import 'MyDAO.dart';

class HighLabelDAO extends MyDAO {
  @override
  initiateTable(MyEntity myEntity) async {
    db = await openDatabase(
      join(await getDatabasesPath(), db_name),
      onOpen: (database) async {
        await database.transaction((txn) async {
          await txn.execute(
            '''
            CREATE TABLE if not exists ${myEntity.table_name}(
              hl_id INTEGER PRIMARY KEY AUTOINCREMENT,
              hl_name TEXT
            );
            ''',
          );
        });
      },
    );
  }
}
