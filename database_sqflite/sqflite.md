# CREATE
> simple

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

> onCreate


onCreate：创建数据库时，创建表。所以把表删了，数据库还在时，initiateTable创建不了表。还得把数据库删了，才能创表。
onOpen：有没有数据库，都会执行创建表的操作。所以选它。但是onOpen似乎没有事务封装，所以onOpen加一个事务。

```dart
// When the database is first created, create a table to store dogs.
// onCreate: (database, version) {
//   // Run the CREATE TABLE statement on the database.
//   // Keep in mind that the callbacks onCreate onUpgrade onDowngrade are already internally wrapped in a transaction
//   database.execute(
//     '''
//     CREATE TABLE if not exists ${myEntity.table_name}(
//       dog_id INTEGER PRIMARY KEY AUTOINCREMENT,
//       dog_name TEXT
//     )
//     ''',
//   );
// },
onOpen: (database){
  database.execute(
  '''
  CREATE TABLE if not exists ${myEntity.table_name}(
    dog_id INTEGER PRIMARY KEY AUTOINCREMENT,
    dog_name TEXT
  )
  ''',
);
},
```

```dart
onOpen: (database){
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
```

- `INT` 不等于 `INTEGER`，前者设置自增`INT PRIMARY KEY AUTOINCREMENT`是失败的，后者`INTEGER PRIMARY KEY AUTOINCREMENT`才行。

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
List<Map> maps = <Map>[];
await db.transaction((txn) async {
  maps = await txn.rawQuery(
    """
    SELECT b.b_id as b_id, b.start_time as start_time, b.end_time as end_time, l.ll_name as ll_name, b.description as description
    FROM ${blackHoleEntity.table_name} as b
    LEFT JOIN ${lowLabelEntity.table_name} as l
    ON b.ll_id = l.ll_id
    where strftime('%Y-%m-%d', start_time) = ?
    ;
    """,
    [selected_time],
  );
});
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

