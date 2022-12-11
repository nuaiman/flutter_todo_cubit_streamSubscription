import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/todo_barrel.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/models/todo_model.dart';

class TodoListBuilder extends StatelessWidget {
  const TodoListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.todos;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        return todoItem(context, todos[index]);
      },
    );
  }

  Widget todoItem(BuildContext context, TodoModel todo) {
    return Dismissible(
      key: ValueKey(todo.id),
      onDismissed: (direction) {
        context.read<TodoListCubit>().deleteTodo(todo.id);
      },
      direction: DismissDirection.endToStart,
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) {
            context.read<TodoListCubit>().toggleTodoStatus(todo.id);
          },
        ),
        title: Text(todo.description),
      ),
    );
  }
}
