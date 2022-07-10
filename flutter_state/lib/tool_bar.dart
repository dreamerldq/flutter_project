import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider.dart';
import 'todo.dart';

class Toolbar extends ConsumerWidget {
  const Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? textColorFor(TodoListFilter value) {
      final filter = BlocProvider.of<TodoListState>(context).state.filterState;
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
        child: BlocBuilder<TodoListState, TodoModel>(builder: (context, state) {
      final uncompletedTodosCount =
          state.todos.where((todo) => !todo.completed).length;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '还有${(uncompletedTodosCount).toString()}个未完成',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: allFilterKey,
            message: '全部',
            child: TextButton(
              onPressed: () => BlocProvider.of<TodoListState>(context)
                  .changeState(TodoListFilter.all), //点击的时候修改筛选的状态
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                    MaterialStateProperty.all(textColorFor(TodoListFilter.all)),
              ),
              child: const Text('全部'),
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: '未完成',
            child: TextButton(
              onPressed: () => BlocProvider.of<TodoListState>(context)
                  .changeState(TodoListFilter.active),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.active),
                ),
              ),
              child: const Text('未完成'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: '已完成',
            child: TextButton(
              onPressed: () => BlocProvider.of<TodoListState>(context)
                  .changeState(TodoListFilter.completed),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.completed),
                ),
              ),
              child: const Text('已完成'),
            ),
          ),
        ],
      );
    }));
  }
}
