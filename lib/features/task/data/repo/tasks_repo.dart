import 'dart:convert';

import 'package:dartz/dartz.dart' hide Task;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/cubit/auth_cubit.dart';
import '../entities/task.dart';

class TasksRepo {
  static Future<Either<String, List<Task>>> getTasks(
    BuildContext ctx,
  ) async {
    try {
      final FirebaseDatabase db = ctx.read<AuthCubit>().state.db;
      final String id =
          (ctx.read<AuthCubit>().state as Authenticated).user.user?.uid ?? "";
      late List<Task> tasks = [];
      await db.ref("tasks/$id").once().then((value) {
        final List jsons = jsonDecode(jsonEncode(value.snapshot.value)) as List;

        for (dynamic item in jsons) {
          final String itemToJson = jsonEncode(item);
          final Map<String, dynamic> itemMap = jsonDecode(itemToJson);
          final Task task = Task.fromMap(itemMap);

          tasks.add(task);
        }
      });
      return Right(tasks);
    } catch (e) {
      return const Left("Có lỗi xảy ra");
    }
  }

  static Future<Either<String, bool>> removeTaskByID(
    BuildContext ctx,
    String uid,
  ) async {
    try {
      final FirebaseDatabase db = ctx.read<AuthCubit>().state.db;

      final String id =
          (ctx.read<AuthCubit>().state as Authenticated).user.user?.uid ?? "";
      final ref = db.ref("tasks/$id");

      ref.once().then((DatabaseEvent event) {
        final jsonContent = event.snapshot.value;

        final List jsons = jsonDecode(jsonEncode(jsonContent)) as List;
        final int index = jsons.indexWhere((element) => element['uid'] == uid);
        if (index != -1) {
          jsons.removeAt(index);
          ref.set(jsons);
        }
      });
      return const Right(true);
    } catch (e) {
      return const Left("Có lỗi xảy ra");
    }
  }

  static Future<Either<String, bool>> updateTask(
      BuildContext ctx, Task task) async {
    try {
      final FirebaseDatabase db = ctx.read<AuthCubit>().state.db;
      final String id =
          (ctx.read<AuthCubit>().state as Authenticated).user.user?.uid ?? "";
      final ref = db.ref("tasks/$id");

      ref.once().then((DatabaseEvent event) {
        final jsonContent = event.snapshot.value;

        final List jsons = jsonDecode(jsonEncode(jsonContent)) as List;
        final int index =
            jsons.indexWhere((element) => element['uid'] == task.uid);
        if (index != -1) {
          jsons[index] = task.toMap();
          ref.set(jsons);
        }
      });

      return const Right(true);
    } catch (e) {
      return const Left("Có lỗi xảy ra");
    }
  }

  static Future<Either<String, bool>> addNewTask(
      BuildContext ctx, Task newTask) async {
    try {
      final FirebaseDatabase db = ctx.read<AuthCubit>().state.db;
      final String id =
          (ctx.read<AuthCubit>().state as Authenticated).user.user?.uid ?? "";

      final ref = db.ref("tasks/$id");
      await ref.once().then((value) {
        final List jsons = jsonDecode(jsonEncode(value.snapshot.value)) as List;

        jsons.add(newTask.toMap());
        ref.set(jsons);
      });
      return const Right(true);
    } catch (e) {
      return const Left("Có lỗi xảy ra");
    }
  }
}
