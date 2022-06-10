import 'package:timehole/Entity/MyEntity.dart';

class HighLabelEntity implements MyEntity {
  late int hl_id;
  late String hl_name;
  @override
  String table_name = 'high_label_table';
  @override
  String key_id_name = 'hl_id';

  HighLabelEntity.list();
  HighLabelEntity.insert(this.hl_name);
  HighLabelEntity.update(this.hl_id, this.hl_name);
  HighLabelEntity.delete(this.hl_id);
  @override
  HighLabelEntity.fromMap(Map<dynamic, dynamic> map) {
    hl_id = map['hl_id'] as int;
    hl_name = map['hl_name'] as String;
  }

  // Convert into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, dynamic> toMap() {
    return {
      'hl_name': hl_name,
    };
  }

  @override
  int getKeyId() {
    return hl_id;
  }

  @override
  void setKeyId(int id) {
    hl_id = id;
  }

  @override
  String toString() {
    return "{'hl_id': $hl_id, 'hl_name': $hl_name}";
  }
}
