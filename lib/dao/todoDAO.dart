// dao/person_dao.dart

import 'package:floor/floor.dart';
import '../entity/todo.dart';

@dao
abstract class TodoDAO {
  @Query('SELECT * FROM Todo')
  Future<List<Todo>> findAllTodo();

  @Query('SELECT * FROM Todo WHERE id = :id')
  Stream<Todo?> findPersonById(int id);

  @insert
  Future<void> insertPerson(Todo todo);

  @delete
  Future<void> deletePerson(Todo todo);
}
