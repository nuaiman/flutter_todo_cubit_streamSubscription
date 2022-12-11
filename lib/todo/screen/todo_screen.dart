import 'package:flutter/material.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/widgets/create_todo.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/widgets/todo_list_builder.dart';
import 'package:flutter_todo_cubit_streamsubscription/todo/widgets/todo_search_and_filter.dart';

import '../widgets/todo_header.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              const TodoHeader(),
              const SizedBox(height: 10),
              const CreateTodo(),
              const SizedBox(height: 20),
              TodoSearchAndFilter(),
              const SizedBox(height: 20),
              const TodoListBuilder(),
            ],
          ),
        ),
      )),
    );
  }
}
