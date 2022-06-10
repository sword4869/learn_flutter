import 'package:untitled/MyEntity.dart';

class BlackHoleEntity implements MyEntity {
  late int b_id;
  late String start_time;
  late String end_time;
  late int ll_id;
  late String description;
  @override
  String table_name = 'blackhole_table';
  @override
  String key_id_name = 'b_id';

  BlackHoleEntity.list();
  BlackHoleEntity.insert(
      this.start_time, this.end_time, this.ll_id, this.description);
  BlackHoleEntity.update(
      this.b_id, this.start_time, this.end_time, this.ll_id, this.description);
  BlackHoleEntity.delete(this.b_id);
  @override
  BlackHoleEntity.fromMap(Map<dynamic, dynamic> map) {
    b_id = map['b_id'] as int;
    start_time = map['start_time'] as String;
    end_time = map['end_time'] as String;
    ll_id = map['ll_id'] as int;
    description = map['description'] as String;
  }

  // Convert into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, dynamic> toMap() {
    return {
      'start_time': start_time,
      'end_time': end_time,
      'll_id': ll_id,
      'description': description,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return "{'b_id': $b_id, 'start_time': $start_time, 'end_time': $end_time, 'll_id': $ll_id, 'description': $description}";
  }

  @override
  int getKeyId() {
    return b_id;
  }

  @override
  void setKeyId(int id) {
    b_id = id;
  }
}
