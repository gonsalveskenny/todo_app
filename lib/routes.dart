import 'package:flutter/material.dart';
import 'package:todo_app/views/task_edit.dart';
import 'package:todo_app/views/task_list.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'task_list': (context) => const TaskList(),
  'task_edit': (context) => const TaskEdit(),
};
