// ignore_for_file: use_build_context_synchronously

import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hcm23_03/features/home/pages/home_page.dart';
import 'package:hcm23_03/features/task/cubits/today_tasks/today_tasks_cubit.dart';
import 'package:hcm23_03/features/task/data/entities/task.dart';
import 'package:hcm23_03/features/task/data/repo/tasks_repo.dart';
import 'package:uuid/uuid.dart';

import '../../../../shared/shared_ui/dialogs/hcm23_dialog.dart';

part 'new_task_state.dart';

class NewTaskCubit extends Cubit<NewTaskState> {
  final TextEditingController titleController =
      TextEditingController(text: "Blank titile");
  final TextEditingController desController =
      TextEditingController(text: "Blank description");

  Task newTask = Task(
    uid: const Uuid().v4(),
    title: "",
    description: "",
    createdAt: null,
    modifiedAt: null,
    startTime: null,
    dueTime: null,
    teamMembers: [],
    taskStages: [],
    active: true,
  );
  NewTaskCubit() : super(const NewTaskState(newTask: null));

  void initState() {
    newTask = newTask.copyWith(
      title: titleController.text,
      description: desController.text,
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      startTime: DateTime.now(),
      dueTime: DateTime.now(),
    );

    titleController.addListener(
      () {
        final Task editedTask = newTask.copyWith(title: titleController.text);
        newTask = editedTask;
        emit(state.copyWith(newTask: newTask));
      },
    );

    desController.addListener(
      () {
        final Task editedTask =
            newTask.copyWith(description: desController.text);
        newTask = editedTask;
        emit(state.copyWith(newTask: newTask));
      },
    );
    emit(NewTaskState(newTask: newTask));
  }

  void handleChange(
    Task currentTask,
    BuildContext ctx,
  ) async {
    await showDialog(
      context: ctx,
      builder: (context) => HCM23Dialog(
        title: 'Thông báo',
        content: "Xác nhận thêm mới bản ghi",
        backgroundColor: Colors.amber,
        titleTextStyle: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
        actions: [
          CleanDialogActionButtons(
            actionTitle: 'OK',
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    await addNewTask(ctx, currentTask);
  }

  Future<Either<String, bool>> addNewTask(
      BuildContext ctx, Task newTask) async {
    EasyLoading.show();

    final result = await TasksRepo.addNewTask(ctx, newTask);
    EasyLoading.dismiss();
    if (result is Right<String, bool>) {
      await showDialog(
        context: ctx,
        builder: (context) => HCM23Dialog(
          title: 'Thông báo',
          content: "Tạo bản ghi mới thành công",
          backgroundColor: Colors.green,
          titleTextStyle: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
          actions: [
            CleanDialogActionButtons(
              actionTitle: 'OK',
              onPressed: () {
                ctx.read<TodayTasksCubit>().getTask(ctx);
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(HomePage.routeName));
              },
            ),
          ],
        ),
      );
    }
    if (result is Left<String, bool>) {
      await showDialog(
        context: ctx,
        builder: (context) => HCM23Dialog(
          title: 'Error',
          content: result.value,
          backgroundColor: Colors.red.withOpacity(0.4),
          titleTextStyle: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
          actions: [
            CleanDialogActionButtons(
              actionTitle: 'OK',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    return result;
  }

  void updateStage(TaskStage stage) {
    final int index = newTask.taskStages.indexWhere(
      (element) => element.uid == stage.uid,
    );
    if (index != -1) {
      List<TaskStage> newStages = [...newTask.taskStages];
      newStages[index] = stage;
      newTask = newTask.copyWith(taskStages: newStages);

      emit(NewTaskState(newTask: newTask));
    }
  }

  void addNewBlankStage() {
    final TaskStage blankStage = TaskStage(
      uid: const Uuid().v4(),
      active: true,
      isDone: false,
      isEditing: true,
    );
    List<TaskStage> newStages = [
      ...newTask.taskStages,
      ...[blankStage]
    ];
    newTask = newTask.copyWith(taskStages: newStages);
    emit(NewTaskState(newTask: newTask));
  }

  void removeTaskStage(TaskStage stage) {
    final int index = newTask.taskStages.indexWhere(
      (element) => element.uid == stage.uid,
    );
    if (index != -1) {
      List<TaskStage> newStages = [
        ...newTask.taskStages..removeAt(index),
      ];
      newTask = newTask.copyWith(taskStages: newStages);
      emit(NewTaskState(newTask: newTask));
    }
  }
}
