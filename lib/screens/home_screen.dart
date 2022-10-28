import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/service/database_service.dart';
import 'package:todo_app/task_provider.dart';
import 'package:todo_app/utils/widgets/update_task_dialog.dart';

import '../utils/functions.dart';
import '../utils/widgets/add_task_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('To Do List',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            StreamBuilder<DatabaseEvent>(
              stream: DatabaseService().tasksStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                List<TaskModel> tasks = snapshot.data!.snapshot.value != null
                    ? (snapshot.data!.snapshot.value! as Map)
                        .entries
                        .toList()
                        .map((e) => TaskModel.fromMap(e.value as Map))
                        .toList()
                    : [];

                return tasks.isEmpty
                    ? LottieBuilder.asset(
                        'lib/assets/lottie/empty_state.json',
                        height: 600,
                      )
                    : Expanded(
                        child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          TaskModel? task = tasks[index];
                          return Card(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: ListTile(
                                    title: Text(task.title),
                                    subtitle: Text(task.defination),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // Text(task.importance),
                                        GestureDetector(
                                          onTap: () {
                                            Provider.of<TaskProvider>(context,
                                                    listen: false)
                                                .deleteTask(key: task.id);
                                          },
                                          child: Icon(Icons.delete),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  UpdateDialog(
                                                taskModel: task,
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.edit),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0)),
                                      color: Functions()
                                          .setImportanceBackGroundColor(
                                              importance: task.importance)),
                                  child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                          "${task.importance.toString()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTaskDialog();
            },
          );
        },
        child: LottieBuilder.asset(
          'lib/assets/lottie/add_item.json',
        ),
      ),
    );
  }
}
