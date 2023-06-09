// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'new_task_cubit.dart';

class NewTaskState {
  final Task? newTask;
  const NewTaskState({required this.newTask});

  NewTaskState copyWith({
    Task? newTask,
  }) {
    return NewTaskState(
      newTask: newTask ?? this.newTask,
    );
  }
}
