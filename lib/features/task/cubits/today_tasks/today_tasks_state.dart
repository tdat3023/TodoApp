// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'today_tasks_cubit.dart';

abstract class TodayTasksState {}

class TodayTaskLoading extends TodayTasksState {}

class TodayTaskLoaded extends TodayTasksState {
  final List<Task> todayTasks;
  TodayTaskLoaded({
    required this.todayTasks,
  });

  TodayTaskLoaded copyWith({
    List<Task>? todayTasks,
  }) {
    return TodayTaskLoaded(
      todayTasks: todayTasks ?? this.todayTasks,
    );
  }
}
