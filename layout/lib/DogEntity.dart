import 'package:layout/MyEntity.dart';

class DogEntity implements MyEntity {
  late int dog_id;
  late String dog_name;
  // 表名
  @override
  String table_name = 'dog_table';
  // id名
  @override
  String key_id_name = 'dog_id';

  // 空白的
  DogEntity.list();
  // 插入是自增，不需要主键
  DogEntity.insert(this.dog_name);
  // 更新全要
  DogEntity.update(this.dog_id, this.dog_name);
  // 删除，有个主键就行
  DogEntity.delete(this.dog_id);
  @override
  DogEntity.fromMap(Map<dynamic, dynamic> map){
    dog_id = map['dog_id'] as int;
    dog_name = map['dog_name'] as String;
  }

  // 不用主键
  // 输入数据库，必须是这样<String, dynamic>，不能是<dynamic, dynamic>
  // Unhandled Exception: type '_InternalLinkedHashMap<dynamic, dynamic>' is not a subtype of type 'Map<String, Object?>' of 'values'
  @override
  Map<String, dynamic> toMap() {
    return {
      'dog_name': dog_name,
    };
  }

  // 因为各表的主键名字不是id
  @override
  int getKeyId(){
    return dog_id;
  }

  // 因为各表的主键名字不是id
  @override
  void setKeyId(int id){
    dog_id = id;
  }

  @override
  String toString(){
    return ('{dog_id : $dog_id, dog_name: $dog_name}');
  }
}
