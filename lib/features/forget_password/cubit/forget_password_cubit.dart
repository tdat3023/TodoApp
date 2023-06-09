import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/cubit/auth_cubit.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final TextEditingController usernameController = TextEditingController();
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  void forgetpassword(BuildContext ctx) async {
    ctx.read<AuthCubit>().forgetPassword(username: usernameController.text);
  }
}
