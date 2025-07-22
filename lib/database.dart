// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/todoDAO.dart';
import 'entity/todo.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Todo])
abstract class AppDatabase extends FloorDatabase {
  TodoDAO get todoDAO;
}
