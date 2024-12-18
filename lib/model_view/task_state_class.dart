part of 'task_cubit_class.dart';

sealed class TaskState {}

// excute logic
final class TaskInitial extends TaskState {}

final class GetDoneTasksLoading extends TaskState {}

final class GetDoneTaskSuccess extends TaskState {}

final class GetDoneTasksError extends TaskState {}

final class GetTasksLoading extends TaskState {}

final class GetTasksSuccess extends TaskState {}

final class GetTasksError extends TaskState {}

final class GetInprogressTasksLoading extends TaskState {}

final class GetInprogressTasksSuccess extends TaskState {}

final class GetInprogressTasksError extends TaskState {}

final class InitDatabaseLoading extends TaskState {}

final class InitDatabaseSuccess extends TaskState {}

final class InitDatabaseError extends TaskState {}

final class MakeTaskDoneLoading extends TaskState {}

final class MakeTaskDoneSuccess extends TaskState {
  final int taskId;

  MakeTaskDoneSuccess({required this.taskId});
}

final class MakeTaskDoneError extends TaskState {}

final class AddNewTaskLoading extends TaskState {}

final class AddNewTaskSuccess extends TaskState {}

final class AddNewTaskError extends TaskState {}

final class DeleteTaskLoading extends TaskState {}

final class DeleteTaskSuccess extends TaskState {
  final int removedTaskId;

  DeleteTaskSuccess({required this.removedTaskId});
}

final class DeleteTaskError extends TaskState {}

final class EditTaskLoading extends TaskState {}

final class EditTaskSuccess extends TaskState {}

final class EditTaskError extends TaskState {}
