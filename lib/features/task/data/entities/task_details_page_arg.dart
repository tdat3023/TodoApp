// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'task.dart';

class TaskDetailsPageArg {
  final Task task;

  final void Function(Task task, BuildContext ctx) updateTask;
  TaskDetailsPageArg({
    required this.task,
    required this.updateTask,
  });
}
