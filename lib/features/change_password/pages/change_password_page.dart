import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hcm23_03/features/change_password/cubit/change_password_cubit.dart';
import 'package:hcm23_03/shared/shared_ui/btn/btn_default/btn_default.dart';
import 'package:hcm23_03/shared/shared_ui/inputs/input_clear/input_clear.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String routeName = "/ChangePasswordPage";
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePasswordPage> {
  late final _cubit = context.read<ChangePasswordCubit>();
  void toggleCurrentPasswordOb() {
    _cubit.toggleCurrentPasswordOb();
  }

  void toggleNewPasswordOb() {
    _cubit.toggleNewPasswordOb();
  }

  void toggleConfirmPasswordOb() {
    _cubit.toggleConfirmPasswordOb();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi mật khẩu",
            style: TextStyle(
              color: Color(0xFF344872),
              fontWeight: FontWeight.w500,
              fontSize: 18,
              height: 22 / 18,
            )),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF344872),
          ),
          onPressed: () {
            // Thực hiện hành động khi nút được nhấn
            Navigator.pop(context); // Quay về trang trước
          },
        ),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
              child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Image.asset('assets/images/background.png'),
                  ),
                  InputClear(
                    controller: _cubit.currentPasswordController,
                    placeholderText: "Mật khẩu hiện tại",
                    clearButton: SvgPicture.asset(
                      "assets/icons/ui_kit/bold/close_square.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    obscureText: state.obscureCurrentPassword,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/icons/ui_kit/normal/shield_done.svg",
                        color: const Color(0XFFA2AEBD),
                        fit: BoxFit.scaleDown,
                      ),
                      suffixIcon: InkWell(
                        onTap: toggleCurrentPasswordOb,
                        child: state.obscureCurrentPassword
                            ? SvgPicture.asset(
                                "assets/icons/ui_kit/bold/hide.svg")
                            : SvgPicture.asset(
                                "assets/icons/ui_kit/bold/show.svg"),
                      ),
                    ),
                  ),
                  InputClear(
                    controller: _cubit.newPasswordController,
                    placeholderText: "Mật khẩu mới",
                    clearButton: SvgPicture.asset(
                      "assets/icons/ui_kit/bold/close_square.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    obscureText: state.obscureNewPassword,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/icons/ui_kit/normal/lock.svg",
                        color: const Color(0XFFA2AEBD),
                        fit: BoxFit.scaleDown,
                      ),
                      suffixIcon: InkWell(
                        onTap: toggleNewPasswordOb,
                        child: state.obscureNewPassword
                            ? SvgPicture.asset(
                                "assets/icons/ui_kit/bold/hide.svg")
                            : SvgPicture.asset(
                                "assets/icons/ui_kit/bold/show.svg"),
                      ),
                    ),
                  ),
                  InputClear(
                    controller: _cubit.confirmPasswordController,
                    placeholderText: "Nhập lại mật khẩu",
                    clearButton: SvgPicture.asset(
                      "assets/icons/ui_kit/bold/close_square.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    obscureText: state.obscureConfirmPassword,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/icons/ui_kit/normal/lock.svg",
                        color: const Color(0XFFA2AEBD),
                        fit: BoxFit.scaleDown,
                      ),
                      suffixIcon: InkWell(
                        onTap: toggleConfirmPasswordOb,
                        child: state.obscureConfirmPassword
                            ? SvgPicture.asset(
                                "assets/icons/ui_kit/bold/hide.svg")
                            : SvgPicture.asset(
                                "assets/icons/ui_kit/bold/show.svg"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: BtnDefault(
                        title: "Huỷ",
                        onTap: onCancel,
                        type: BtnDefaultType.secondary,
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: BtnDefault(
                        title: "Cập nhật",
                        onTap: () {
                          onUpdate(context);
                        },
                        type: BtnDefaultType.primary,
                      )),
                    ],
                  ),
                ],
              );
            },
          )),
        ),
      ),
    );
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

  void onUpdate(BuildContext ctx) {
    context.read<ChangePasswordCubit>().updatePassword(ctx);
  }
}
