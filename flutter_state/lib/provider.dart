import 'package:flutter/material.dart';
import 'todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Some keys used for testing
final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

const listAll = [
  Todo(id: 'todo-0', description: 'hi'),
  Todo(id: 'todo-1', description: 'hello'),
  Todo(id: 'todo-2', description: 'bonjour'),
];

class TodoListState extends Cubit<TodoModel> {
  TodoListState()
      : super(TodoModel(
            todos: listAll,
            // filterTodos: listAll,
            filterState: TodoListFilter.all));
  void add(String description) => emit(state.copyWith(todos: [
        // state代表TodoList对象的返回值，每次返回都是一个新的对象
        ...state.todos,
        Todo(
          id: _uuid.v4(),
          description: description,
        ),
      ]));

  void toggle(String id) => emit(state.copyWith(todos: [
        for (final todo in state.todos)
          if (todo.id == id)
            Todo(
              id: todo.id,
              completed: !todo.completed,
              description: todo.description,
            )
          else
            todo,
      ]));
  void changeState(TodoListFilter filter) {
    emit(state.copyWith(filterState: filter));
  }

  void remove(Todo target) => emit(state.copyWith(
      todos: state.todos.where((todo) => todo.id != target.id).toList()));

  // void filterTodos() {
  //   switch (state.filterState) {
  //     case TodoListFilter.completed:
  //       emit(state.copyWith(
  //           filterTodos:
  //               state.todos.where((todo) => todo.completed).toList()));
  //       break;
  //     case TodoListFilter.active:
  //       emit(state.copyWith(
  //           filterTodos:
  //               state.todos.where((todo) => !todo.completed).toList()));
  //       break;

  //     case TodoListFilter.all:
  //       emit(state.copyWith());
  //       break;
  //   }
  // }
}
