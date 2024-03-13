import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/services/task_service.dart';

class TaskViewModel extends ChangeNotifier {
  List<TaskModel>? taskModelList;
  int? indexValue;
  bool status = false;
  bool loading = false;
  getTaskModel() async {
    taskModelList = await FetchTasks().onUrl();
    notifyListeners();
  }

  setIndexValue(int value) {
    indexValue = value;
    notifyListeners();
  }

  resetIndexValue() {
    indexValue = null;
    notifyListeners();
  }

  updateTask(String id, String title, String desc) async {
    loading = true;
    notifyListeners();
    status = await UpdateTasks(id: id, title: title, desc: desc).onUrl();
    taskModelList = await FetchTasks().onUrl();
    loading = false;
    notifyListeners();
  }

  newTask(String title, String desc) async {
    loading = true;
    notifyListeners();
    status = await NewTask(title: title, desc: desc).onUrl();
    taskModelList = await FetchTasks().onUrl();
    indexValue = taskModelList!.length - 1;
    loading = false;
    notifyListeners();
  }

  resetStatus() {
    status = false;
    notifyListeners();
  }

  shareFiles(String title) async {
    await Share.share('com.example.todo_app', subject: title);
  }
}
