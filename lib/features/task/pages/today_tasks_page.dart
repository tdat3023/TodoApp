// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcm23_03/features/task/data/entities/task_details_page_arg.dart';
import 'package:hcm23_03/features/task/pages/task_details_page.dart';

import '../../global/presentation/base_screen/base_screen.dart';
import '../cubits/today_tasks/today_tasks_cubit.dart';
import '../widgets/task_card.dart';

class TodayTasksPage extends StatefulWidget {
  const TodayTasksPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TodayTasksPage> createState() => _TodayRecordsPageState();
}

class _TodayRecordsPageState extends State<TodayTasksPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Today Task",
          ),
        ),
        body: BlocBuilder<TodayTasksCubit, TodayTasksState>(
          builder: (context, state) {
            if (state is TodayTaskLoaded) {
              return RefreshIndicator(
                key: context.read<TodayTasksCubit>().refreshIndicatorKey,
                color: Colors.white,
                backgroundColor: Colors.blue,
                strokeWidth: 4.0,
                onRefresh: () async {
                  context.read<TodayTasksCubit>().getTask(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    height: double.infinity,
                    child: state.todayTasks.isNotEmpty
                        ? ListView.separated(
                            padding: const EdgeInsets.only(bottom: 20),
                            itemBuilder: (context, index) {
                              final color = Color(
                                      (math.Random().nextDouble() * 0xFFFFFF)
                                          .toInt())
                                  .withOpacity(0.1);

                              return TaskCard(
                                key: UniqueKey(),
                                task: state.todayTasks[index],
                                color: color,
                                viewTask: () async {
                                  await Navigator.of(context).pushNamed(
                                    TaskDetailsPage.routeName,
                                    arguments: TaskDetailsPageArg(
                                      task: state.todayTasks[index],
                                      updateTask: context
                                          .read<TodayTasksCubit>()
                                          .updateTask,
                                    ),
                                  );
                                  context
                                      .read<TodayTasksCubit>()
                                      .getTask(context);
                                },
                                deleteTask: () {
                                  context.read<TodayTasksCubit>().deleteTask(
                                        state.todayTasks[index].uid ?? "",
                                        context,
                                      );
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                height: 0.5,
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.5),
                              );
                            },
                            itemCount: state.todayTasks.length,
                          )
                        : Container()),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    });
  }
}
