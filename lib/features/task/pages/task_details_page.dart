// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:hcm23_03/features/task/data/entities/task_details_page_arg.dart';
import 'package:hcm23_03/shared/shared_ui/inputs/input_normal/input_normal.dart';

import '../../../shared/shared_ui/btn/btn_default/btn_default.dart';
import '../../global/presentation/base_screen/base_screen.dart';
import '../cubits/task_details/task_details_cubit.dart';
import '../data/entities/task.dart';
import '../widgets/task_stage_input.dart';

class TaskDetailsPage extends StatefulWidget {
  static const String routeName = "/TaskDetailsPage";
  final TaskDetailsPageArg arg;

  const TaskDetailsPage({
    Key? key,
    required this.arg,
  }) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late final TaskDetailsCubit cubit = context.read<TaskDetailsCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (context) {
      return BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Task Details",
              ),
              elevation: 0,
            ),
            body: state is TaskDetailsLoaded
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 28,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Task title",
                                style: TextStyle(color: Color(0XFF5D6B98)),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputNormal(
                                      placeholderText: "Enter task's title",
                                      controller: cubit.titleController,
                                      valueTextStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        enabled: false,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Due date",
                                style: TextStyle(color: Color(0XFF5D6B98)),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.lock_clock,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SizedBox(
                                    child: Text(
                                      DateFormat("dd/MM/yyyy")
                                          .format(DateTime.now()),
                                      style: const TextStyle(
                                          color: Color(0XFF5D6B98)),
                                    ),
                                  ),
                                  const Spacer(),
                                  _buildTaskStatus(null)
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Description",
                                style: TextStyle(color: Color(0XFF5D6B98)),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: InputNormal(
                                    placeholderText: "Enter task's description",
                                    controller: cubit.descriptionController,
                                    minLines: 1,
                                    maxLines: 5,
                                    valueTextStyle: const TextStyle(
                                      color: Color(0XFF111322),
                                      fontSize: 14,
                                    ),
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero),
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 71,
                                    child: Stack(
                                      children: [
                                        ...List.generate(
                                          min(state.task.teamMembers.length, 5),
                                          (index) => Positioned(
                                            left: 12.0 * index,
                                            top: 0,
                                            bottom: 0,
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              padding: const EdgeInsets.all(1),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.blue,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      state
                                                              .task
                                                              .teamMembers[
                                                                  index]
                                                              .avatarUrl ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if ((state.task.teamMembers.length) > 5)
                                    Text(
                                        "+${(state.task.teamMembers.length) - 5}"),
                                ],
                              ),
                              // if (state.task != null) _buildTeamMembers(state)
                            ],
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Stages of task",
                                style: TextStyle(color: Color(0XFF5D6B98)),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(),
                                itemBuilder: ((context, index) {
                                  return (state.task.taskStages[index]
                                              .isEditing ==
                                          true)
                                      ? TaskStageInput(
                                          onChanged: (String? val) {
                                            cubit.updateStage(
                                              state.task.taskStages[index]
                                                  .copyWith(
                                                description: val ?? "",
                                              ),
                                            );
                                          },
                                          onRemove: () {
                                            cubit.removeTaskStage(
                                                state.task.taskStages[index]);
                                          },
                                          onChecked: () {
                                            cubit.updateStage(
                                              state.task.taskStages[index]
                                                  .copyWith(
                                                isEditing: false,
                                              ),
                                            );
                                          },
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0XFF000000)
                                                      .withOpacity(0.05),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Checkbox(
                                                      shape:
                                                          const CircleBorder(),
                                                      value: state
                                                          .task
                                                          .taskStages[index]
                                                          .isDone,
                                                      onChanged: (val) {
                                                        cubit.updateStage(
                                                          state.task
                                                              .taskStages[index]
                                                              .copyWith(
                                                                  isDone: val),
                                                        );
                                                      },
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        state
                                                                .task
                                                                .taskStages[
                                                                    index]
                                                                .description ??
                                                            "",
                                                        style: TextStyle(
                                                          color: const Color(
                                                                  0xff30374f)
                                                              .withOpacity(0.7),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            BtnDefault(
                                              type: BtnDefaultType.secondary,
                                              width: 40,
                                              onTap: () {
                                                cubit.removeTaskStage(state
                                                    .task.taskStages[index]);
                                              },
                                              customChild: const Icon(
                                                Icons.remove,
                                                size: 16,
                                              ),
                                            ),
                                          ],
                                        );
                                }),
                                separatorBuilder: (context, idx) =>
                                    const SizedBox(
                                  height: 12,
                                ),
                                itemCount: state.task.taskStages.length,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    cubit.addNewBlankStage();
                                  },
                                  child: const Text("+ Stage"),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                          BtnDefault(
                            onTap: () {
                              cubit.handleChange(
                                  state.task, context, widget.arg.updateTask);
                            },
                            title: "Save change",
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      );
    });
  }

  TaskProgress status(Task? task) {
    if (task == null) {
      return TaskProgress.imcoming;
    }
    int doneTask = 0;
    for (TaskStage stage in task.taskStages) {
      if (stage.isDone == true) {
        doneTask++;
      }
    }
    if ((task.startTime ?? DateTime.now()).isAfter(DateTime.now())) {
      return TaskProgress.imcoming;
    }
    if ((task.dueTime ?? DateTime.now()).isBefore(DateTime.now()) &&
        doneTask < task.taskStages.length) {
      return TaskProgress.failure;
    }
    if (doneTask == task.taskStages.length) {
      return TaskProgress.done;
    }

    return TaskProgress.inProgress;
  }

  Widget _buildTaskStatus(Task? currentTask) {
    final TaskProgress progress = status(currentTask);

    switch (progress) {
      case TaskProgress.inProgress:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xff039855).withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Text(
            "In progress",
            style: TextStyle(fontSize: 12, color: Color(0xff039855)),
          ),
        );
      case TaskProgress.imcoming:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Text(
            "Comming up",
            style: TextStyle(fontSize: 12, color: Colors.purple),
          ),
        );
      case TaskProgress.failure:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Text(
            "Failed",
            style: TextStyle(fontSize: 12, color: Colors.red),
          ),
        );

      default:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Text(
            "Done",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        );
    }
  }
}
