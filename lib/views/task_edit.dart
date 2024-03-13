import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view_models/task_view_model.dart';

class TaskEdit extends StatefulWidget {
  const TaskEdit({super.key});

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(builder: (context, taskViewModel, child) {
      if (taskViewModel.indexValue != null) {
        titleController.text =
            taskViewModel.taskModelList![taskViewModel.indexValue!].taskName!;
        descriptionController.text = taskViewModel
            .taskModelList![taskViewModel.indexValue!].taskDescription!;
      }
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleController.text == '' && descriptionController.text == ''
                  ? const Text('New Task')
                  : const Text('Edit Task'),
              InkWell(
                onTap: titleController.text == '' &&
                        descriptionController.text == ''
                    ? () {
                        taskViewModel.newTask(
                            titleController.text, descriptionController.text);
                        if (taskViewModel.status) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Success"),
                            ),
                          );
                          taskViewModel.resetStatus();
                        }
                      }
                    : () {
                        taskViewModel.updateTask(
                            taskViewModel
                                .taskModelList![taskViewModel.indexValue!].sId!,
                            titleController.text,
                            descriptionController.text);
                        if (taskViewModel.status) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Success"),
                            ),
                          );
                          taskViewModel.resetStatus();
                        }
                      },
                child: const Icon(Icons.check),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: taskViewModel.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(hintText: 'Title'),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
