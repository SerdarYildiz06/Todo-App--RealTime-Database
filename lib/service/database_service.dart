import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/model/task_model.dart';

class DatabaseService {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseService() {
    firebaseDatabase.databaseURL =
        'https://todo-app-e3951-default-rtdb.europe-west1.firebasedatabase.app/';
  }

  Future<void> createTask({required TaskModel taskModel}) async {
    await firebaseDatabase
        .ref()
        .child('tasks')
        .update({taskModel.id: taskModel.toMap()});
  }

  Future<List<TaskModel?>> getTasks() async {
    DataSnapshot dataSnapshot =
        await firebaseDatabase.ref().child('tasks').get();

    List<TaskModel> taskModel = dataSnapshot.value != null
        ? (dataSnapshot.value! as Map)
            .entries
            .toList()
            .map((e) => TaskModel.fromMap(e.value as Map))
            .toList()
        : [];

    print(taskModel.toList());
    return taskModel;
  }

  Future<void> deleteTask({required String key}) async {
    await firebaseDatabase.ref().child('tasks').child(key).remove();
  }

  Stream<DatabaseEvent> tasksStream() {
    return firebaseDatabase.ref().child('tasks').onValue;
  }

  Future<void> updateTask({required TaskModel taskModel}) async {
    await firebaseDatabase
        .ref()
        .child('tasks')
        .update({taskModel.id: taskModel.toMap()});
  }
}
