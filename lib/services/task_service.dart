import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/task_model.dart';

String url =
    'https://crudcrud.com/api/73e642e936b74bdba112d36c0541dde5/todoapp';

class FetchTasks {
  List tasks = [];
  Future<List<TaskModel>?> onUrl() async {
    try {
      final response = await http.get(Uri.parse(url));
      tasks = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
    return tasks.map((e) => TaskModel.fromJson(e)).toList();
  }
}

class UpdateTasks {
  String id;
  String title;
  String desc;
  UpdateTasks({required this.id, required this.title, required this.desc});
  Future<bool> onUrl() async {
    try {
      final response = await http.put(
        Uri.parse('$url/$id'),
        body: jsonEncode(
          {
            "taskName": title,
            "taskDescription": desc,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}

class NewTask {
  String title;
  String desc;
  NewTask({required this.title, required this.desc});
  Future<bool> onUrl() async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {
            "taskName": title,
            "taskDescription": desc,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
