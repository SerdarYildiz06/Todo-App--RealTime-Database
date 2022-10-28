import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../task_provider.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
    return AlertDialog(
      backgroundColor: Colors.grey.shade300,
      title: Text('Add Task'),
      content: Form(
        key: taskProvider.addTaskDformKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskProvider.taskTitleController,
              decoration: const InputDecoration(hintText: 'Enter Task Title'),
            ),
            TextField(
              controller: taskProvider.taskDescriptionController,
              decoration:
                  const InputDecoration(hintText: 'Enter Task Description'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: taskProvider.importanceController,
              maxLength: 1,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration:
                  const InputDecoration(hintText: 'Enter Task Importance'),
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
            await taskProvider.addTask(context);

            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
