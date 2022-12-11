import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/filter/todo_filter_cubit.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/list/todo_list_cubit.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/search/todo_search_cubit.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/models/todo_model.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  late final StreamSubscription filterSubscription;
  late final StreamSubscription searchSubscription;
  late final StreamSubscription listSubscription;

  final List<TodoModel> initialTodoList;

  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  FilteredTodosCubit({
    required this.initialTodoList,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
  }) : super(FilteredTodosState(todos: initialTodoList)) {
    filterSubscription = todoFilterCubit.stream.listen((event) {
      getFilteredTodos();
    });
    searchSubscription = todoSearchCubit.stream.listen((event) {
      getFilteredTodos();
    });
    listSubscription = todoListCubit.stream.listen((event) {
      getFilteredTodos();
    });
  }

  void getFilteredTodos() {
    List<TodoModel> filteredTodos;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        filteredTodos = todoListCubit.state.todos
            .where((element) => !element.isDone)
            .toList();
        break;
      case Filter.done:
        filteredTodos = todoListCubit.state.todos
            .where((element) => element.isDone)
            .toList();
        break;
      case Filter.all:
        filteredTodos = todoListCubit.state.todos.toList();
        break;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((element) => element.description
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(todos: filteredTodos));
  }

  @override
  Future<void> close() {
    filterSubscription.cancel();
    searchSubscription.cancel();
    listSubscription.cancel();
    return super.close();
  }
}
