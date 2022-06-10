import 'package:flutter/widgets.dart';
import 'package:layout/MyEntity.dart';


abstract class MyDAO{
  late var db;

  Future initiateTable(MyEntity myEntity);

  Future close();

  Future insertEntity(MyEntity myEntity);

  Future deleteEntity(MyEntity myEntity);

  Future deleteTable(MyEntity myEntity);

  Future<bool> deleteDB();

  Future<List<Map>> listEntity(MyEntity myEntity);

  Future updateEntity(MyEntity myEntity);
}