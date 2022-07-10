import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'todo.dart';

/// Some keys used for testing
final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

/// StateNotifierProvider提供复杂对象的处理能力 泛型第一个参数是Provider的返回值，第二个参数是StateNotofer对象
final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList(const [
    Todo(id: 'todo-0', description: 'hi'),
    Todo(id: 'todo-1', description: 'hello'),
    Todo(id: 'todo-2', description: 'bonjour'),
  ]);
});

/// The different ways to filter the list of todos
enum TodoListFilter {
  all,
  active,
  completed,
}
/// StateProvider常用于枚举类型的处理
final todoListFilter = StateProvider((_) => TodoListFilter.all);
/// 这就是一个混合的provder，先使用todoListProvider获取值
final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});

/// 混合Provider 通过todoListFiter获取筛选的状态，然后通过todoListProvider获取列表数据，然后通过处理之后，返回新的值

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});
/// Provider 处理简单的值逻辑
final currentTodo = Provider<Todo>((ref) => throw UnimplementedError());