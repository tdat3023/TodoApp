// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../global/cubit/auth_cubit.dart';

part 'login_state.dart';

const String rememberAccountKey = "rememberAccountKey";

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginCubit()
      : super(const LoginState(
          hidePassword: true,
          rememberAccount: false,
        ));

  void loginWithUsernameAndPw(BuildContext ctx) async {
    ctx.read<AuthCubit>().loginWithUsernameAndPw(
          ctx: ctx,
          username: usernameController.text,
          password: passwordController.text,
          rememberAccount: state.rememberAccount,
        );
  }

  void changeRememberAccount(bool? value) {
    emit(state.copyWith(rememberAccount: value));
  }

  void toogleHidePassword() {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}
