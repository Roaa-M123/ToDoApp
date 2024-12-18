import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_project/core/localDatabase.dart';
import 'package:todo_project/model/models/task_model.dart';
part 'task_state_class.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  static TaskCubit get(context) {
    return BlocProvider.of(context);
  }

  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper();
  List<TaskModel> doneTasks = []; //display done tasks
  List<TaskModel> inProgressTasks = []; //display inProgress tasks

  void initDatabase() async {
    emit(InitDatabaseLoading());
    try {
      await localDatabaseHelper.initDatabase(
          databasePathName: "task_app",
          onCreate: (database, version) async {
            await database.execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,isDone INTEGER,dateTime TEXT,level TEXT)');
          });
      emit(InitDatabaseSuccess());
    } catch (e) {
      print(e);
      emit(InitDatabaseError());
    }
  }

  Future<void> getDoneTasksList() async {
    doneTasks.clear();
    emit(GetDoneTasksLoading());
    try {
      final List<Map<String, dynamic>> list = await localDatabaseHelper.getData(
          tableName: "tasks", where: "isDone = 1");

      print("during getDoneTasksList, the list contains =${list}");
      for (var Element in list) {
        doneTasks.add(
          TaskModel.fromMap(Element),
        );
        print(doneTasks);
      }
      emit(GetDoneTaskSuccess());
    } catch (e) {
      emit(GetDoneTasksError());
    }
  }

  Future<void> getInProgressTaskList() async {
    inProgressTasks.clear();
    emit(GetInprogressTasksLoading());
    try {
      final List<Map<String, dynamic>> list = await localDatabaseHelper.getData(
          tableName: "tasks", where: "isDone = 0");

      print("during getInProgressTaskList, the list contains =${list}");
      for (var Element in list) {
        inProgressTasks.add(TaskModel.fromMap(Element));
      }
      emit(GetInprogressTasksSuccess());
    } catch (e) {
      emit(GetInprogressTasksError());
    }
  }

  Future<void> deleteTask({required int removedTaskId}) async {
    emit(DeleteTaskLoading());
    try {
      await localDatabaseHelper.deleteDatabase(
        tableName: "tasks",
        where: "id = ?",
        whereArgs: [removedTaskId],
      );
      emit(DeleteTaskSuccess(removedTaskId: removedTaskId));
    } catch (e) {
      emit(DeleteTaskError());
    }
  }

  Future<void> makeTaskDone({required int taskId}) async {
    emit(MakeTaskDoneLoading());
    try {
      await localDatabaseHelper.updateDatabase(
          values: {"isDone": 1}, tableName: "tasks", query: "id= $taskId");
      emit(MakeTaskDoneSuccess(taskId: taskId));
    } catch (e) {
      emit(MakeTaskDoneError());
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> AddNewTask({required TaskModel taskModel}) async {
    emit(AddNewTaskLoading());
    try {
      await localDatabaseHelper.insertToDatabase(
          values: taskModel.toMap(), tableName: "tasks");
      emit(AddNewTaskSuccess());
    } catch (e) {
      emit(AddNewTaskError());
    }
  }

  Future<void> editTask({required TaskModel taskModel}) async {
    emit(EditTaskLoading());
    try {
      await localDatabaseHelper.updateDatabase(
        values: taskModel.toMap(),
        tableName: "tasks",
        query: "id = ?", 
        args: [taskModel.id], 
      );
      emit(EditTaskSuccess());
    } catch (e) {
      print(e);
      emit(EditTaskError());
    }
  }
}
// AddMultiTask() async {
//   for (int i = 0; i <= 500; i++) {
//     await localDatabaseHelper.insertToDatabase(
//         values: TaskModel(
//           title: "Task number $i",
//           dateTime: "2024-11-26 03:17:00.000",
//           level: "Medium",
//         ).toMap(),
//         tableName: "tasks");
//   }
// }

// void getTaskList() async {
//   emit(GetTasksLoading());
//   try {
//     final List<Map<String, dynamic>> list =
//         await localDatabaseHelper.getData(tableName: 'tasks', where: '');
//     for (var Element in list) {
//       doneTasks.add(TaskModel.fromMap(Element));
//       emit(GetTasksSuccess());
//     }
//   } catch (e) {
//     print(e);
//     emit(GetTasksError());
//   }
// }

//   void getInprogressTasks() {
//     emit(GetInprogressTasksLoading());
//     try {
//       for (var task in listTaskModel) {
//         if (task.isDone == false) {
//           inProgressTasks.add(task);
//         }
//       }
//       emit(GetInprogressTasksSuccess());
//     } catch (e) {
//       emit(GetInprogressTasksError());
//     }
//   }
//
//
