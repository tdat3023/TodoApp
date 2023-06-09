// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hcm23_03/features/forget_password/cubit/forget_password_cubit.dart';
import 'package:hcm23_03/features/global/presentation/base_screen/base_screen.dart';

import '../../../shared/shared_ui/btn/btn_default/btn_default.dart';
import '../../../shared/shared_ui/inputs/input_clear/input_clear.dart';
import '../../../shared/shared_ui/themes/colors.dart';
import '../../../shared/shared_ui/themes/text_styles.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const String routeName = '/ForgetPasswordPage';
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  // final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Quên mật khẩu"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child:
                        Image.asset("assets/images/image_forgetpassword.png"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Đừng lo lắng! Hãy nhập email của bạn để lấy lại mật khẩu qua tài khoản email.",
                    style: tStyle
                        .paragraph14()
                        .w400()
                        .copyWith(color: Hcm23Colors.colorTextPhude),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputClear(
                    controller:
                        context.read<ForgetPasswordCubit>().usernameController,
                    placeholderText: "Tài khoản",
                    clearButton: SvgPicture.asset(
                      "assets/icons/ui_kit/bold/close_square.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/icons/ui_kit/normal/user.svg",
                        color: const Color(0XFFA2AEBD),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  BtnDefault(
                    title: "Lấy mật khẩu mới",
                    onTap: () {
                      context
                          .read<ForgetPasswordCubit>()
                          .forgetpassword(context);
                    },
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
