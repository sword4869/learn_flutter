abstract class MyEntity {
  late String table_name;
  late String key_id_name;

  MyEntity.fromMap(Map<dynamic, dynamic> map);

  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  int getKeyId();

  void setKeyId(int id);
}
