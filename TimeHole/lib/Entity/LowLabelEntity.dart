import 'package:timehole/Entity/MyEntity.dart';

class LowLabelEntity implements MyEntity {
  late int ll_id;
  late String ll_name;
  late int hl_id;
  late bool star;
  @override
  String table_name = 'low_lable_table';
  @override
  String key_id_name = 'll_id';

  LowLabelEntity.list();
  LowLabelEntity.insert(this.ll_name, this.hl_id, this.star);
  LowLabelEntity.update(this.ll_id, this.ll_name, this.hl_id, this.star);
  LowLabelEntity.delete(this.ll_id);
  @override
  LowLabelEntity.fromMap(Map<dynamic, dynamic> map) {
    ll_id = map['ll_id'] as int;
    ll_name = map['ll_name'] as String;
    hl_id = map['hl_id'] as int;
    star = map['star'] == 1;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'll_name': ll_name,
      'hl_id': hl_id,
      'star': star == false ? 0 : 1,
    };
  }

  @override
  int getKeyId() {
    return ll_id;
  }

  @override
  void setKeyId(int id) {
    ll_id = id;
  }

  @override
  String toString() {
    return "{'ll_id': $ll_id, 'll_name': $ll_name, 'hl_id': $hl_id, 'star': $star}";
  }
}
