# CREATE
> onCreate
```dart
// Not in a transaction.
db.execute(
'''
CREATE TABLE if not exists Test (
    id INTEGER PRIMARY KEY,
    name TEXT,
    num REAL)
''',
);
```

```dart
initiateTable(MyEntity myEntity) async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();

    // Open the database and store the reference.
    var database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), db_name),
      // When the database is first created, create a table to store dogs.
      // Keep in mind that the callbacks onCreate onUpgrade onDowngrade are already internally wrapped in a transaction
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute('''
          CREATE TABLE ${myEntity.table_name}(
            id INTEGER PRIMARY KEY,
            name TEXT,
            age INTEGER)
          ''',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    // Get a reference to the database.
    return database;
  }
```
> transaction

```dart
await database.transaction((txn) async {
  // Ok
  await txn.execute('CREATE TABLE if not exists Test1 (id INTEGER PRIMARY KEY)');

  // DON'T  use the database object in a transaction
  // this will deadlock!
  await database.execute('CREATE TABLE if not exists Test2 (id INTEGER PRIMARY KEY)');
});
```

```dart
await database.transaction((txn) async {
  await txn.execute('''
    CREATE TABLE if not exists Test1 (
        id INTEGER PRIMARY KEY)
    ''',
  );
});
```

# INSERT
```dart
await db.transaction((txn) async {
  int id1 = await txn.rawInsert('''
        INSERT INTO Test(name, value, num)
        VALUES("some name", 1234, 456.789)
        ''',
        );
  print('inserted1: $id1');
  int id2 = await txn.rawInsert('''
        INSERT INTO Test(name, value, num)
        VALUES(?, ?, ?)
        ''',
        ['another name', 12345678, 3.1416],
        );
  print('inserted2: $id2');
});
```

```dart
Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(
        tableTodo,
        todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return todo;
}
print(id);
```

# DELETE
```dart
// Delete a record
count = await database.rawDelete('''
    DELETE FROM Test
    WHERE name = ?
    ''',
    ['another name'],
);
```
```dart
Future<int> delete(Todo todo) async {
    return await db.delete(
        tableTodo,
        where: '$columnId = ?',
        whereArgs: [todo.id],
        );
}
```

# LIST
```dart
// Get the records
List<Map> maps = await database.rawQuery('SELECT * FROM Test');
```
```dart
List<Map<String, Object?>> records = await db.query('my_table');
```
# SELECT
```dart
Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(
        tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id],
        );
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
}
```

# UPDATE
```dart
// Update some record
int count = await database.rawUpdate('''
    UPDATE Test SET
    name = ?, value = ?
    WHERE name = ?''',
    ['updated name', '9876', 'some name']);
print('updated: $count');
```
```dart
Future<int> update(Todo todo) async {
    return await db.update(
        tableTodo,
        todo.toMap(),
        where: '$columnId = ?',
        whereArgs: [todo.id],
        );
}
```