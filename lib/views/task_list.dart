import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view_models/task_view_model.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final List<String> tasks = ["Task 1", "Task 2", "Task 3"];
  bool checkFlag = false;
  @override
  void initState() {
    super.initState();
    Provider.of<TaskViewModel>(context, listen: false).getTaskModel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(builder: (context, taskViewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('To Do Tasks'),
              InkWell(
                onTap: () {
                  taskViewModel.resetIndexValue();
                  Navigator.pushNamed(context, 'task_edit');
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => taskViewModel.getTaskModel(),
          child: taskViewModel.taskModelList == null
              ? Container()
              : ListView.builder(
                  itemCount: taskViewModel.taskModelList!.length,
                  itemBuilder: (context, index) {
                    final reversedIndex =
                        taskViewModel.taskModelList!.length - 1 - index;
                    return InkWell(
                      onTap: () {
                        taskViewModel.setIndexValue(reversedIndex);
                        Navigator.pushNamed(context, 'task_edit');
                      },
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(taskViewModel
                                .taskModelList![reversedIndex].taskName!),
                            InkWell(
                              onTap: () {
                                taskViewModel.shareFiles(taskViewModel
                                    .taskModelList![reversedIndex].taskName!);
                              },
                              child: const Icon(Icons.share),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      );
    });
  }
}
