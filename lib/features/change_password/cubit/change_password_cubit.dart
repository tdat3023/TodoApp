import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcm23_03/features/global/cubit/auth_cubit.dart';
import 'package:hcm23_03/features/global/data/entities/hcm23_user.dart';
import 'package:hcm23_03/shared/shared_ui/dialogs/hcm23_dialog.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  ChangePasswordCubit()
      : super(const ChangePasswordState(
          obscureCurrentPassword: true,
          obscureNewPassword: true,
          obscureConfirmPassword: true,
        ));

  void updatePassword(BuildContext ctx) async {
    final Hcm23User hcm23user =
        (ctx.read<AuthCubit>().state as Authenticated).hcm23user;
    if (hcm23user.password != currentPasswordController.text) {
      showDialog(
        context: ctx,
        builder: (context) => HCM23Dialog(
          title: 'Error',
          content: "Mật khẩu bạn nhập không đúng",
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
    } else {
      ctx.read<AuthCubit>().updatePassword(ctx, newPasswordController.text);
    }
  }

  void toggleCurrentPasswordOb() {
    obscureCurrentPassword = !obscureCurrentPassword;
    emit(state.copyWith(obscureCurrentPassword: obscureCurrentPassword));
  }

  void toggleNewPasswordOb() {
    obscureNewPassword = !obscureNewPassword;
    emit(state.copyWith(obscureNewPassword: obscureNewPassword));
  }

  void toggleConfirmPasswordOb() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(state.copyWith(obscureConfirmPassword: obscureConfirmPassword));
  }
}
