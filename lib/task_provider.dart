import 'package:flutter/material.dart';
import 'package:todo_app/service/database_service.dart';
import 'package:todo_app/utils/widgets/my_snacbar.dart';

import 'model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController importanceController = TextEditingController();
  final updateTaskformKey = GlobalKey<FormState>();
  final addTaskDformKey = GlobalKey<FormState>();

  Future<void> addTask(context) async {
    if (taskTitleController.text.isEmpty) {
      MySnackbar.show(context,
          message: 'Title cannot be empty', backgroundColor: Colors.red);
    }
    if (taskDescriptionController.text.isEmpty) {
      MySnackbar.show(context,
          message: 'Description cannot be empty', backgroundColor: Colors.red);
    }
    if (importanceController.text.isEmpty) {
      MySnackbar.show(context,
          message: 'Importance value cannot be empty',
          backgroundColor: Colors.red);
    }
    TaskModel taskModel = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: taskTitleController.text,
      defination: taskDescriptionController.text,
      importance: int.parse(importanceController.text),
    );

    await DatabaseService().createTask(taskModel: taskModel);
    notifyListeners();
  }

  Future<void> updateTask({required TaskModel taskModel}) async {
    await DatabaseService().updateTask(taskModel: taskModel);
    notifyListeners();
  }

  Future<void> deleteTask({required String key}) async {
    await DatabaseService().deleteTask(key: key);
    notifyListeners();
  }
}
