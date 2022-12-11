import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/cubits/list/todo_list_cubit.dart';

part 'todo_active_count_state.dart';

class TodoActiveCountCubit extends Cubit<TodoActiveCountState> {
  late final StreamSubscription todoListSubscription;

  final int initialActiveCount;
  final TodoListCubit todoListCubit;
  TodoActiveCountCubit({
    required this.initialActiveCount,
    required this.todoListCubit,
  }) : super(TodoActiveCountState(activeCount: initialActiveCount)) {
    todoListSubscription = todoListCubit.stream.listen((event) {
      final int currentActiveCount = todoListCubit.state.todos.length;
      emit(state.copyWith(activeCount: currentActiveCount));
    });
  }
  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
