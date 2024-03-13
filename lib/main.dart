import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/view_models/task_view_model.dart';
import 'package:todo_app/views/task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TaskList(),
        routes: routes,
      ),
    );
  }
}
