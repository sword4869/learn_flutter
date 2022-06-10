import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class MyEntity{
  late String table_name;
  late String key_id_name;

  MyEntity.fromMap(Map<dynamic, dynamic> map);

  Map<dynamic, Object?> toMap() {
    throw UnimplementedError();
  }

  // 因为 keyid 名字不确定，从而无法MyEntity.id
  int getKeyId();

  // 同理
  void setKeyId(int id);
}