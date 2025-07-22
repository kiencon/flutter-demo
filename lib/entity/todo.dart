import 'package:floor/floor.dart';

@entity
class Todo {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int quantity;

  final String name;

  Todo(this.id, this.name, this.quantity);
}
