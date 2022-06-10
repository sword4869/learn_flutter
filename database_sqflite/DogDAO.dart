import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'MyEntity.dart';
import 'MyDAO.dart';

class DogDAO extends MyDAO {
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
}
