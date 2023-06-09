// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/cubit/auth_cubit.dart';
import '../../task/data/entities/task.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(const HomeState(
          currentPage: 0,
        ));
  final PageController pageController = PageController(initialPage: 0);

  void logout(BuildContext context) async {
    context.read<AuthCubit>().logout();
  }

  void changePage(int? idx) {
    if (idx != state.currentPage) {
      pageController.animateToPage(idx ?? 0,
          duration: const Duration(milliseconds: 250), curve: Curves.linear);
      emit(state.copyWith(currentPage: idx));
    }
  }

  void reload(int? idx) {
    if (idx != state.currentPage) {
      pageController.animateToPage(idx ?? 0,
          duration: const Duration(milliseconds: 250), curve: Curves.linear);
      emit(state.copyWith(currentPage: idx));
    }
  }
}
