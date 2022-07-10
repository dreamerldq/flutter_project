import 'package:flutter/foundation.dart' show immutable;


/// A read-only description of a todo-item
@immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;

  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

enum TodoListFilter {
  all,
  active,
  completed,
}

class TodoModel{
  TodoModel({required this.todos, required this.filterState});
  List<Todo> todos = [];
  // List<Todo> filterTodos;
  TodoListFilter filterState = TodoListFilter.all;
  TodoModel copyWith({
    List<Todo>? todos,
    List<Todo>?filterTodos,
    TodoListFilter? filterState,
  }) {
    return TodoModel(
      todos: todos ?? this.todos,
      // filterTodos:filterTodos?? this.filterTodos,
      filterState: filterState ?? this.filterState,
    );
  }
}
