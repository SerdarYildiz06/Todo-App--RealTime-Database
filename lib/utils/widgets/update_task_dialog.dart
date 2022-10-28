import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task_model.dart';

import '../../task_provider.dart';

class UpdateDialog extends StatelessWidget {
  UpdateDialog({
    Key? key,
    required this.taskModel,
  }) : super(key: key);
  TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
    return AlertDialog(
      backgroundColor: Colors.grey.shade300,
      title: Text('Update Task'),
      content: Form(
        key: taskProvider.updateTaskformKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskProvider.taskTitleController,
              decoration: InputDecoration(hintText: taskModel.title),
            ),
            TextField(
              controller: taskProvider.taskDescriptionController,
              decoration: InputDecoration(hintText: taskModel.defination),
            ),
            TextField(
              controller: taskProvider.importanceController,
              decoration:
                  InputDecoration(hintText: taskModel.importance.toString()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            taskModel.title = taskProvider.taskTitleController.text;
            taskModel.defination = taskProvider.taskDescriptionController.text;
            taskModel.importance =
                int.parse(taskProvider.importanceController.text);
            await taskProvider.updateTask(taskModel: taskModel);
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
