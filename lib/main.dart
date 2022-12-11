import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/active_count/todo_active_count_cubit.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/filter/todo_filter_cubit.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/filtered_todos/filtered_todos_cubit.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/list/todo_list_cubit.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/search/todo_search_cubit.dart';

import 'todo/screen/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ---------------------------------------------------------------------
        BlocProvider<TodoFilterCubit>(create: (context) => TodoFilterCubit()),
        // ---------------------------------------------------------------------
        BlocProvider<TodoSearchCubit>(create: (context) => TodoSearchCubit()),
        // ---------------------------------------------------------------------
        BlocProvider<TodoListCubit>(create: (context) => TodoListCubit()),
        // ---------------------------------------------------------------------
        BlocProvider<TodoActiveCountCubit>(
          create: (context) => TodoActiveCountCubit(
            initialActiveCount:
                BlocProvider.of<TodoListCubit>(context).state.todos.length,
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
        // ---------------------------------------------------------------------
        BlocProvider<FilteredTodosCubit>(
          create: (context) => FilteredTodosCubit(
            initialTodoList:
                BlocProvider.of<TodoListCubit>(context).state.todos.toList(),
            todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
            todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
        // ---------------------------------------------------------------------
      ],
      child: MaterialApp(
        title: 'Flutter Todo Cubits & StreamSubscription',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoScreen(),
      ),
    );
  }
}
