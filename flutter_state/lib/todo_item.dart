import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state/provider.dart';
import 'package:flutter_state/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key, this.todo}) : super(key: key);
  final Todo? todo;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 6,
      child: ListTile(
          leading: Checkbox(
              value: todo!.completed,
              onChanged: (value) =>
                  BlocProvider.of<TodoListState>(context).toggle(todo!.id)),
          title: Text(todo!.description)),
    );
  }
}
