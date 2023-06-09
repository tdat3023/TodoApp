// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcm23_03/features/task/cubits/new_task/new_task_cubit.dart';
import 'package:intl/intl.dart';

import 'package:hcm23_03/shared/shared_ui/inputs/input_normal/input_normal.dart';

import '../../../shared/shared_ui/btn/btn_default/btn_default.dart';
import '../../global/presentation/base_screen/base_screen.dart';
import '../widgets/task_stage_input.dart';

class NewTaskPage extends StatefulWidget {
  static const String routeName = "/NewTaskPage";

  const NewTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  late final NewTaskCubit cubit = context.read<NewTaskCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "New Task",
              ),
              elevation: 0,
            ),
            body: BlocBuilder<NewTaskCubit, NewTaskState>(
              builder: (context, state) {
                return SingleChildScrollView(
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
                              "Start time",
                              style: TextStyle(
                                color: Color(0XFF5D6B98),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  child: Text(
                                    DateFormat("dd/MM/yyyy hh:MM")
                                        .format(DateTime.now()),
                                    style: const TextStyle(
                                        color: Color(0XFF5D6B98)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(
                                  Icons.lock_clock,
                                  size: 16,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Due time",
                              style: TextStyle(
                                color: Color(0XFF5D6B98),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  child: Text(
                                    DateFormat("dd/MM/yyyy hh:MM")
                                        .format(DateTime.now()),
                                    style: const TextStyle(
                                        color: Color(0XFF5D6B98)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(
                                  Icons.lock_clock,
                                  size: 16,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
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
                                  controller: cubit.desController,
                                  minLines: 3,
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
                                return (state.newTask?.taskStages[index]
                                            .isEditing ==
                                        true)
                                    ? TaskStageInput(
                                        onChanged: (String? val) {
                                          cubit.updateStage(
                                            state.newTask!.taskStages[index]
                                                .copyWith(
                                              description: val ?? "",
                                            ),
                                          );
                                        },
                                        onRemove: () {
                                          cubit.removeTaskStage(
                                              state.newTask!.taskStages[index]);
                                        },
                                        onChecked: () {
                                          cubit.updateStage(
                                            state.newTask!.taskStages[index]
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
                                                    shape: const CircleBorder(),
                                                    value: state
                                                        .newTask
                                                        ?.taskStages[index]
                                                        .isDone,
                                                    onChanged: (val) {
                                                      cubit.updateStage(
                                                        state.newTask!
                                                            .taskStages[index]
                                                            .copyWith(
                                                                isDone: val),
                                                      );
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      state
                                                              .newTask
                                                              ?.taskStages[
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
                                                  .newTask!.taskStages[index]);
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
                              itemCount: state.newTask?.taskStages.length ?? 0,
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
                              cubit.newTask,
                              context,
                            );
                          },
                          title: "Save change",
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}
