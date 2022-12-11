import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/todo_barrel.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODOS',
          style: TextStyle(fontSize: 40),
        ),
        Text(
          '${context.watch<TodoActiveCountCubit>().state.activeCount} items left',
          style: const TextStyle(fontSize: 20, color: Colors.red),
        ),
      ],
    );
  }
}
