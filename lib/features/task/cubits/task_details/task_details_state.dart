// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_details_cubit.dart';

abstract class TaskDetailsState {
  const TaskDetailsState();
}

class TaskDetailsLoading extends TaskDetailsState {}

class TaskDetailsLoaded extends TaskDetailsState {
  final Task task;
  TaskDetailsLoaded({
    required this.task,
  });
}
