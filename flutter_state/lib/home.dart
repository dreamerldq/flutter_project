import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state/tool_bar.dart';

import 'provider.dart';
import 'todo.dart';
import 'todo_item.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newTodoController = TextEditingController(); // 文本控制器

    return GestureDetector(
      child: Scaffold(body:
          BlocBuilder<TodoListState, TodoModel>(builder: (context, state) {
        final filteList;
        switch (state.filterState) {
          case TodoListFilter.completed:
            filteList = state.todos.where((todo) => todo.completed).toList();
            break;
          case TodoListFilter.active:
             filteList = state.todos.where((todo) => !todo.completed).toList();
            break;

          case TodoListFilter.all:
            filteList = state.todos;
            break;
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            TextField(
              key: addTodoKey,
              controller: newTodoController,
              decoration: const InputDecoration(
                labelText: '请输入新的todo?',
              ),
              onSubmitted: (value) {
                // 回车后执行
                BlocProvider.of<TodoListState>(context)
                    .add(value); // 调用add方法，添加新的todo
                newTodoController.clear();
              },
            ),
            const SizedBox(height: 42),
            const Toolbar(),
            if (filteList.isNotEmpty) const Divider(height: 10),
            for (var i = 0; i < filteList.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              Dismissible(
                key: ValueKey(filteList[i].id),
                onDismissed: (_) {
                  BlocProvider.of<TodoListState>(context)
                      .remove(filteList[i]); //
                },
                child: TodoItem(todo: filteList[i]),
              )
            ],
          ],
        );
      })),
    );
  }
}
