abstract class MyEntity {
  late String table_name;
  late String key_id_name;

  MyEntity.fromMap(Map<dynamic, dynamic> map);

  // 用于插入，因为是自增主键，所以不需要主键
  Map<dynamic, Object?> toMap() {
    throw UnimplementedError();
  }

  // 因为 keyid 名字不确定，从而无法MyEntity.id
  int getKeyId();

  // 同理
  void setKeyId(int id);
}
